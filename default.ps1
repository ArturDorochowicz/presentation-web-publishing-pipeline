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

task build2 -description "Explict settings and logging" {
	Invoke-MSBuild `
		-ProjectPath $Solution `
		-Target $ProjectBuildTarget `
		-Property (mergehashtables $Properties @{ 
			DeployTarget = 'Package'
			AutoParameterizationWebConfigConnectionStrings = 'false'
			EnablePackageProcessLoggingAndAssert = 'true'
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
