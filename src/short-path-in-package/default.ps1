task package {
    msbuild 'short-path-in-package.csproj' /verbosity:minimal /property:RequireRestoreConsent=false /property:Configuration=Release `
        /property:DeployOnBuild=true
}