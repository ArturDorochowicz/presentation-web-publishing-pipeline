task package {
    msbuild 'aspnet-compilation.csproj' /verbosity:minimal /property:RequireRestoreConsent=false /property:Configuration=Release `
        /property:DeployOnBuild=true
}