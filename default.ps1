Framework '4.0x86'

properties {
	$Solution = 'MvcApplication1.sln'
	$ProjectBuildTarget = 'MvcApplication1'
	$Properties = @{
		Configuration = 'Release'
		DeployOnBuild = 'true'
	}
}


task default -depends build1


task build1 -description "Default behavior" {
	Invoke-MSBuild `
		-ProjectPath $Solution `
		-Target $ProjectBuildTarget `
		-Property $Properties
}

task build2 -description "Explict settings with logging" {
	Invoke-MSBuild `
		-ProjectPath $Solution `
		-Target $ProjectBuildTarget `
		-Property (mergehashtables $Properties @{ 
			DeployTarget = 'Package'   # default: Package
			AutoParameterizationWebConfigConnectionStrings = 'false'  # default: true 
			EnablePackageProcessLoggingAndAssert = 'true'   # default: false
            FilesToIncludeForPublish = 'OnlyFilesToRunTheApp'   #  AllFilesInProjectFolder, AllFilesInTheProject, default: OnlyFilesToRunTheApp
            WebPublishPipelineProjectName = 'MyWebApp'   # default: project name
            DefaultDeployIisAppPath = 'Default Web Site\MyWebApp123'   # default: Default Web Site\project name
		})
}


task build3 -description "Just copy the files and do web.config transformations" {
	Invoke-MSBuild `
		-ProjectPath $Solution `
		-Target $ProjectBuildTarget `
		-Property (mergehashtables $Properties @{ 
			DeployTarget = 'PipelinePreDeployCopyAllFilesToOneFolder'
		})
}


function mergehashtables($htold, $htnew)
{
    $keys = $htold.getenumerator() | foreach-object {$_.key}
    $keys | foreach-object {
        $key = $_
        if ($htnew.containskey($key))
        {
            $htold.remove($key)
        }
    }
    $htnew = $htold + $htnew
    return $htnew
}

function Invoke-MSBuild {
	[CmdletBinding()]
	param(
		[Parameter(Position=0,Mandatory=1)] [string] $ProjectPath,
		[Parameter(Position=1)] [string[]] $Target,
		[Parameter(Position=2)] [hashtable] $Property,
		[string] $VerbosityLevel = 'minimal',
		[ValidateNotNullOrEmpty()] [string] $MSBuild = 'msbuild.exe'
	)

	$arguments = @(
		$ProjectPath
		'/maxcpucount'
		"/verbosity:${VerbosityLevel}"
	)

	if ($Target) {
		$arguments += ($Target | %{ '/target:{0}' -f $_ })
	}

	if ($Property) {
		$arguments += ($Property.GetEnumerator() | %{ '/property:{0}={1}' -f $_.Key, $_.Value })
	}

	"msbuild ${arguments}"
	exec { & $MSBuild $arguments }
}
