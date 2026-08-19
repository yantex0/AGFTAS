#==============================================================================
# My Personal PowerShell Profile
#==============================================================================

#==============================================================================
# 1. Script to install software for below functions
#==============================================================================

# Script to install packages and modules referred to in this profile is in the same folder in the Github repo.

#==============================================================================
# 2. Software Packages
#==============================================================================

# Terminal Icons
Import-Module -Name Terminal-Icons

# Oh My Posh
if (Get-Command "oh-my-posh") {
    oh-my-posh init pwsh --config $Home\cobalt2.omp.json | Invoke-Expression
}

# Zoxide
if (Get-Command "zoxide") {
    zoxide init --cmd z powershell | Out-String | Invoke-Expression
}

# PSFzf Integration
if (Get-Module -ListAvailable -Name PSFzf) {
    Import-Module PSFzf

    # Configure Preview Window (Right side, toggled with Ctrl+/) & enable fuzzy tab completion
    Set-PsFzfOption -TabExpansion -TabCompletionPreviewWindow 'right|down|hidden'
    Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

    # Bind Ctrl+r (Reverse History) and Ctrl+t (Provider Path Selection)
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

    Set-Alias -Name fe -Value Invoke-FuzzyEdit
    Set-Alias -Name fgs -Value Invoke-FuzzyGitStatus
    Set-Alias -Name fh -Value Invoke-FuzzyHistory
    Set-Alias -Name fkill -Value Invoke-FuzzyKillProcess
    Set-Alias -Name fd -Value Invoke-FuzzySetLocation
    Set-Alias -Name fs -Value Invoke-FuzzyScoop
} else {
    # Fallback to MenuComplete if PSFzf isn't installed
    Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
}

# PSUKnowledge
if (Get-Module -ListAvailable -Name PSUtil) {
    Import-Module -Name PSUtil
    Set-PSFConfig -Module PSUtil -Name Knowledge.LibraryPath -Value "$Home\.Dotter-Files\psutil-knowledge"
    Set-Alias -Name "New-Note" -Value Write-PSUKnowledge; Set-Alias -Name "noten" -Value Write-PSUKnowledge
    Set-Alias -Name "Get-Note" -Value Write-PSUKnowledge; Set-Alias -Name "noteg" -Value Write-PSUKnowledge
    Set-Alias -Name "Remove-Note" -Value Write-PSUKnowledge; Set-Alias -Name "noter" -Value Write-PSUKnowledge
}

# Microsoft Edit Wrapper (Will use new 2.0 Microsoft Edit if available instead of default version that is pre-installed with Windows)
function edit {
    $wingetEdit = Get-Command edit.exe -All | Where-Object { $_.Version -ge [Version]"2.0.0.0" } | Select-Object -First 1
    if ($wingetEdit) {
        & $wingetEdit.Source $args
    } else {
        & "$env:windir\System32\edit.exe" $args
    }
}

# Dotter Wrapper
if (Get-Command "dotter") {
    function dotter {
        $originalPath = Get-Location
        Set-Location -Path "$Home\.Dotter-Files"
        try {
            & ".\dotter.exe" $args
        } finally {
            Set-Location -Path $originalPath
        }
    }
}

#==============================================================================
# 3. History & Colors
#==============================================================================

Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionViewStyle ListView -Colors @{
    Command   = '#87CEEB'
    Parameter = '#98FB98'
    Operator  = '#FFB6C1'
    Variable  = '#DDA0DD'
    String    = '#FFDAB9'
    Number    = '#B0E0E6'
    Type      = '#F0E68C'
    Comment   = '#D3D3D3'
    Keyword   = '#8367c7'
    Error     = '#FF6347'
}

#==============================================================================
# 4. KeyBinds
#==============================================================================

# History Navigation
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Text Editing
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord 'Alt+d' -Function DeleteWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord

# Clipboard & Undo
Set-PSReadLineKeyHandler -Chord 'Ctrl+z' -Function Undo
Set-PSReadLineKeyHandler -Chord 'Ctrl+y' -Function Redo
Set-PSReadLineKeyHandler -Chord 'Ctrl+v' -Function Paste

#==============================================================================
# 5. Functions
#==============================================================================

# File / Directory Utilities
function ff ($Name) { Get-ChildItem -Recurse -Filter *$Name* -File | Select-Object -ExpandProperty FullName }
function docs { Set-Location -Path ([Environment]::GetFolderPath('MyDocuments')) }

# System Utilities
function uptime { (Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime | Select-Object Days, Hours, Minutes, Seconds }
function which ($Name) { (Get-Command $Name).Source }

# Listing / Viewing
function la { Get-ChildItem | Format-Table -AutoSize }
function ll { Get-ChildItem -Force | Format-Table -AutoSize }

#==============================================================================
# 6. Help System (Show-Help Alias and Function Below)
#==============================================================================

Write-Host "Use 'Show-Help (or sh)' to list all available functions" -ForegroundColor Yellow
Set-Alias -Name sh -Value Show-Help

function Show-Help {
    $title = $PSStyle.Foreground.BrightMagenta
    $section = $PSStyle.Foreground.BrightBlue
    $command = $PSStyle.Foreground.BrightGreen
    $desc = $PSStyle.Foreground.BrightWhite
    $accent = $PSStyle.Foreground.BrightYellow
    $dim = $PSStyle.Foreground.BrightBlack
    $reset = $PSStyle.Reset

    Write-Host @"
${title} PowerShell Profile Help${reset}
${dim}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${reset}
    ${section} Common Shortcuts${reset}
${dim}────────────────────────────────────────────────────${reset}
        ${command}dotter${reset}            ${accent}→${reset} ${desc}Uses dotter CLI${reset}
        ${command}edit${reset}              ${accent}→${reset} ${desc}Open MS Edit${reset}
        ${command}mcd <dir>${reset}         ${accent}→${reset} ${desc}Create + enter dir${reset}
${dim}────────────────────────────────────────────────────${reset}
    ${section} Knowledge ${reset}
${dim}────────────────────────────────────────────────────${reset}
        ${command}New-Note${reset}          ${accent}→${reset} ${desc}Create Knowledge Note${reset}
        ${command}Get-Note${reset}          ${accent}→${reset} ${desc}Read Knowledge Note${reset}
        ${command}Remove-Note${reset}       ${accent}→${reset} ${desc}Remove Knowledge Note${reset}
${dim}────────────────────────────────────────────────────${reset}
    ${section} File / Directory ${reset}
${dim}────────────────────────────────────────────────────${reset}
        ${command}docs${reset}              ${accent}→${reset} ${desc}Go to Documents folder${reset}
        ${command}desktop${reset}           ${accent}→${reset} ${desc}Go to Desktop folder${reset}
        ${command}ff <name>${reset}         ${accent}→${reset} ${desc}Search for files${reset}
        ${command}ll${reset}                ${accent}→${reset} ${desc}List files${reset}
${dim}────────────────────────────────────────────────────${reset}
    ${section} System ${reset}
${dim}────────────────────────────────────────────────────${reset}
        ${command}uptime${reset}            ${accent}→${reset} ${desc}System uptime${reset}
        ${command}which <name>${reset}      ${accent}→${reset} ${desc}Locate command${reset}
${dim}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${reset}
"@
}