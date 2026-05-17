# Graph Script Structure

## Useful Parts for all Graph Scripts

### Install Graph Modules

No matter what you want to do using Graph, the necessary modules must be installed and available within in scope of the user running the cmdlets.

```powershell
# This installs ALL Graph Modules
Install-Module -Name Microsoft.Graph -Scope AllUsers -Force
```

### Adding 'Requires' at the top of the script

This ensures that the PowerShell script won't run if the modules aren't available.

Example:

```powershell
#Requires -Modules Microsoft.Graph.Authentication
#Requires -Modules Microsoft.Graph.DeviceManagement
```
