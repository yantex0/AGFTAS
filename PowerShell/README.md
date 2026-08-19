<h1 align="center">PowerShell Things and Stuff</h1>

<br />

I love PowerShell, it's awesome. It does so much, it is (mostly) intuitive, its powerful, its fun.

So this is documentation about PowerShell 7+ aka [PowerShell Core](https://learn.microsoft.com/en-au/powershell/scripting/overview?view=powershell-7.6). It is safe to assume everything in AGFTAS is always about PowerShell Core unless stated otherwise. To try and make things as simple as possible to understand, I will refer to PowerShell 7+ as 'PowerShell Core' and PowerShell 5.1 as 'Microsoft PowerShell'.

The easiest way to get PowerShell Core (and SO much other software on Windows) is by using Winget initially via 'Windows PowerShell' (once we have PowerShell Core, we can use winget there instead). Open 'Windows PowerShell' in the start menu and enter `winget install -i Microsoft.PowerShell` ('Microsoft.PowerShell' in this context IS PowerShell Core, how confusing!), this will launch an interactive install of PowerShell Core.

Also it is safe to assume I will always be using 'Windows Terminal' but you can use the PowerShell console by clicking PowerShell (NOT 'Windows PowerShell' though!) directly in the start menu.

If you run into any issues, run `$PSVersionTable` in your PowerShell and check what PSVersion says, is it 5.1 or 7+ ?

