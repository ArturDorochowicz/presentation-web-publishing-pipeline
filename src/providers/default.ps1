task package {
    msbuild 'providers.csproj' /verbosity:minimal /property:RequireRestoreConsent=false /property:Configuration=Release `
        /property:DeployOnBuild=true
}