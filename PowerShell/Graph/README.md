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

### Documentation from Microsoft about Graph

* https://github.com/microsoftgraph/msgraph-training-powershell
* https://github.com/microsoftgraph/msgraph-sdk-powershell
* https://github.com/microsoft/mggraph-intune-samples
* https://developer.microsoft.com/en-us/graph

### Assorted Links about Graph or Graph Scripts

https://o365reports.com/ms-graph-powershell-scripts-microsoft-365-it-pros/

