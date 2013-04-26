task package {
    msbuild 'include-exclude-files.csproj' /verbosity:minimal /property:RequireRestoreConsent=false /property:Configuration=Release `
        /property:DeployOnBuild=true `
        /property:EnablePackageProcessLoggingAndAssert=true
}