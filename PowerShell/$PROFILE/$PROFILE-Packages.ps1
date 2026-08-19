# Copy and Paste the below into PowerShell to install all the packages and modules that are referred to in $PROFILE file.
# I 1000% think it is worth looking into Dotter (or another dotfile manager) is NOT included here as it takes a bit of understanding to set it up.

$wingetPackages = @(
    "JanDeDobbeleer.OhMyPosh",
    "ajeetdsouza.zoxide",
    "junegunn.fzf",
    "Microsoft.Edit"
)

foreach ($wingetPackage in $wingetPackages) {
    winget.exe install --id $wingetPackage --exact --source winget --accept-source-agreements --disable-interactivity --silent --accept-package-agreements --force
}

$powershellModules = @(
    "Terminal-Icons",
    "PSFzf",
    "PSUtil"
)

foreach ($powershellModule in $powershellModules) {
    Install-Module -Name $powershellModule -Scope CurrentUser -Force
}