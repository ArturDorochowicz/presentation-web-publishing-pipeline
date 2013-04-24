task defaults {
    msbuild "WPP basics.csproj" /verbosity:minimal /property:RequireRestoreConsent=false /property:Configuration=Release `
        /property:DeployOnBuild=true
}

task basic_properties {
    msbuild "WPP basics.csproj" /verbosity:minimal /property:RequireRestoreConsent=false /property:Configuration=Release `
        /property:DeployOnBuild=true `
        /property:DeployTarget=Package `
        /property:AutoParameterizationWebConfigConnectionStrings=false `
        /property:EnablePackageProcessLoggingAndAssert=true `
        /property:FilesToIncludeForPublish=OnlyFilesToRunTheApp `
        /property:WebPublishPipelineProjectName=MyWebApp `
        '/property:DefaultDeployIisAppPath=Default Web Site\MyWebApp123'

# Defaults:
#  DeployTarget=Package
#  AutoParameterizationWebConfigConnectionStrings=true
#  EnablePackageProcessLogginAndAssert=false
#  FilesToIncludeForPublish=OnlyFilesToRunTheApp   // AllFilesInProjectFolder, AllFilesInTheProject, OnlyFilesToRunTheApp
#  WebPublishPipelineProjectName=<project-name>
#  DefaultDeployIisAppPath=Default Web Site\<project-name>
}