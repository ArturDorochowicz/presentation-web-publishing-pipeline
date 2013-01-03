$_psakePath = Join-Path (Split-Path $MyInvocation.MyCommand.Definition) 'packages/psake.4.2.0.1/tools/'

Set-Alias psake (Join-Path $_psakePath 'psake.ps1')


Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)
. (Join-Path $_psakePath 'tabexpansion/PsakeTabExpansion.ps1')
Pop-Location

if(-not (Test-Path Function:\DefaultTabExpansion)) {
    Rename-Item Function:\TabExpansion DefaultTabExpansion
}

# Set up tab expansion and include psake expansion
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1]
    
    switch -regex ($lastBlock) {
        # Execute psake tab completion for all psake-related commands
        '(Invoke-psake|psake) (.*)' { PsakeTabExpansion $lastBlock }
        # Fall back on existing tab expansion
        default { DefaultTabExpansion $line $lastWord }
    }
}
