# PowerShell $PROFILE

## What is $PROFILE in relation to PowerShell?

In short, one of the coolest parts of PowerShell that allows you to add your own customisations and flair.

If you have done any scripting in PowerShell, you will likely know variables always start with a $ symbol. You might have also noticed that $PROFILE starts with a $ symbol, meaning $PROFILE is a variable, but what information does it store? Well, the path to where Powershell checks for your profile... file!

Consider this a choose your own adventure style README file:
1. If you want to immediately start editing your Powershell profile, [click here](#straight-into-the-action). (High level overview)
2. If you want to get a bit more of an understand of what your Powershell profile can do for you, [click here](#deeper-dive-slightly). (A bit of a deeper dive, not too much, don't worry.)

### Straight into the action

While the file path itself that $PROFILE points to always exists, you must ensure there is actually a file there that Powershell will check!

Open 'Windows Terminal', if you haven't used it before, it should open to Powershell 5.1

### Deeper Dive (Slightly) 