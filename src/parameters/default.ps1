task package {
    msbuild 'parameters.csproj' /verbosity:minimal /property:RequireRestoreConsent=false /property:Configuration=Release `
        /property:DeployOnBuild=true `
        /property:MyOtherSettingParameterDefaultValue=def
}