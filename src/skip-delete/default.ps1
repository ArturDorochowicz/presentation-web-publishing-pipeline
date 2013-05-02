task package {
    msbuild 'skip-delete.csproj' /verbosity:minimal /property:RequireRestoreConsent=false /property:Configuration=Release `
        /property:DeployOnBuild=true
}