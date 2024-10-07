# Components/Terminal/TerminalIcons 🗀

## Setup
One of my go-to PowerShell Modules is [Terminal-Icons](https://github.com/devblackops/Terminal-Icons), which does what it sounds like.. it adds cool icons and colours to the terminal when running Cmdlets like `Get-ChildItem`

Setup is simple, running the below in the terminal will install the latest version from the PowerShell Gallery.
```
Install-Module -Name Terminal-Icons -Repository PSGallery
```

Once installed the output is something like this;

![Screenshot of my PowerShell Terminal with Terminal-Icons.](/Components/Terminal/TerminalIcons/TerminalIconsImage.PNG)

## Whats Included?
I include some .psd1 files that allow me to customise the colours and recognised folders/file extensions.
+ [`ColourConfig.psd1`](/Components/Terminal/TerminalIcons/ColourConfig.psd1)
+ [`IconConfig.psd1`](/Components/Terminal/TerminalIcons/IconConfig.psd1)