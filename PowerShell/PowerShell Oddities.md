# Weird/Interesting Stuff in PowerShell

## Overview

There is no real point to this file, I don't even know if I will ever expand on it past this one thing but who knows.

### foreach vs ForEach-Object

So I write standard `foreach` loops in VSCodium quite often like this:

```powershell
foreach ($x in $y) {
    Write-Output $x
}
```

However this time, I piped an object into `foreach` like this:

```powershell
$pipingObject | foreach
```

I noticed after doing this that the PowerShell extension's built-in linter (PSScriptAnalyzer) underlined it because `foreach` is an alias of `ForEach-Object` and I should avoid aliases. I already knew about it being an alias but I am so used to writing `foreach` and that's it. So I thought, I will write a loop but use `ForEach-Object` in the loop instead of `foreach`:

```powershell
ForEach-Object ($x in $y) {
    Write-Output $x
}
```

I was very confused when it showed up with an error saying I was missing a parentheses, there is no missing parentheses?! I checked that `foreach` actually is an alias of `ForEach-Object` and it is as shown here:

```powershell
PS C:\> Get-Alias foreach

CommandType     Name                                     Version    Source
-----------     ----                                     -------    ------
Alias           foreach -> ForEach-Object
```

So what gives? Well, I learnt something new here myself! I'll do my best to explain, let's break this down into 3 instances:

```powershell
<# 1. #> foreach ($letter in @("a","b","c")) { Write-Output $letter }
<# 2. #> @("a","b","c") | foreach { Write-Output $PSItem }
<# 3. #> @("a","b","c") | ForEach-Object { Write-Output $_ }
```

* **Example 1:** This is the classic "do something to each item in a pre-defined collection" foreach here is **NOT** an alias of `ForEach-Object` but rather a PowerShell keyword. This is used when you have a pre-defined list of items and you want to run through that list.
* **Example 2:** In this context `foreach` **IS** an alias of `ForEach-Object` and `ForEach-Object` is primarily designed to have objects piped into it. Then to refer to the item within the loop, you use `$PSItem` or `$_` as seen above.
* **Example 3:** `ForEach-Object` is primarily designed to have objects piped into it. Then to refer to the item within the loop, you use `$PSItem` or `$_` as seen above.
    * It is uncommon but you *can* use `ForEach-Object` with the -inputObject and -Process parameters like this: `ForEach-Object -InputObject @("a","b","c") -Process { Write-Output $_ }` and to be more confusing, you **CAN'T** write `foreach -InputObject...` at the start of a line. Because it's at the beginning of the statement, PowerShell forces it to be a keyword (which doesn't understand parameters) rather than an alias.
