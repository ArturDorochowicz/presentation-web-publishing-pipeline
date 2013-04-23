task default_target {
    msbuild project.proj /verbosity:minimal
}

task explicit_target {
    msbuild project.proj /verbosity:minimal /target:FirstTarget
}

task set_property {
    msbuild project.proj /verbosity:minimal /property:AfterMyDefaultTargetMessage=123
}

task items {
    msbuild project.proj /verbosity:minimal /target:FileTarget
}
