# Components/Terminal 📒

## Setup 🚀
As I primarily use PowerShell on Windows, my terminal of choice is the Windows Terminal, the Components/Terminal directory contains all my custom settings, and keybindings, which are then setup using Symlink to the correct location

* [`settings.json`](settings.json)

I also include some custom colour and icon settings for [Terminal-Icons](https://github.com/devblackops/Terminal-Icons)

+ [`ColourConfig.psd1`](/Components/Terminal/TerminalIcons/ColourConfig.psd1)
+ [`IconConfig.psd1`](/Components/Terminal/TerminalIcons/IconConfig.psd1)

## Keybindings
I try to make sure the keybindings for my Terminal follow the same logic as the ones for VSCode found here [`keybindings.json`](/Components/VSCode/keybindings.json)

`Alt Key` Used for **Navigation** actions (Changing views, moving between the explorer and the editor.)\
`Ctrl Key` Used for **Non-Navigation** actions (Search, Find & Replace, close editors etc.)\
`Shift Key` Used for **Complementary** actions (assigned with either the `Alt` or `Ctrl` key.)

### Common Shortcuts

#### Alt + KEY

`Alt+D` Move to the right pane\
`Alt+Shift+D` Open new pane to the right\
`Alt+A` Move to the left pane\
`Alt+Shift+A` Open new pane to the left\
`Alt+W` Move to the top pane\
`Alt+Shift+W` Open new pane to the top\
`Alt+S` Move to the below pane\
`Alt+Shift+S` Open new pane below\
`Alt+Shift+D` Delete current pane