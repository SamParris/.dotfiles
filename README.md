# > .dotfiles (Windows Environment Configuration) 🖥️

## What is it?
My completely customised .dotfiles setup for Windows 🚀 This is based heavily on the way .dotfiles are used within Linux for control and customisations on both the OS as well as various apps - using `winget` to install and update software.

PowerShell is my main focus and what I use most of this for, so that is what this has been designed around.

This project and GitHub Repo is developed for my own sole enjoyment and personal learning, the only "End-User" I care about in all of this, is myself 😂 I make no promises on any usability, stability or practicality of anything found here.

### Whats included?
- XML file loading for components and the required configurations 
- Installing missing components silently via `winget`  
- Symbolic link creation

---

## How does it work?
The backbone for this whole setup is in the [`Setup.ps1`](Setup.ps1) file, once the repo is cloned and [`Setup.ps1`](Setup.ps1) is ran, it will install and configure all the various apps or OS settings I use on a daily basis, allowing me to quickly setup new PCs that I'm using or ensure my settings are the same across multiple PCs.

### Prerequisites
> [!IMPORTANT]\
> Currently my .dotfiles is only designed to work in Windows, as I dont use any other OS its highly unlikely I will change that..

**Only thing you need to ensure is that [`winget`](https://learn.microsoft.com/en-us/windows/package-manager/winget/#install-winget) is installed prior to running [`Setup.ps1`](Setup.ps1)**

## Installation 🚀

> [!WARNING]\
> This is very much under _**active development**_, nothing is perfect. Some things may break, or be overwritten... proceed with caution!

- Clone https://github.com/SamParris/.dotfiles.git into your folder of choice (I personally recommend cloning directly into *C:\Users\YOURNAME*  this will create .dotfiles within your HOME directory.)
- Ensure `Config.xml` and `Components.xml` are configured properly.
- Open **PowerShell as Administrator**.
- Run the Setup.ps1 file:

```powershell
.\Setup.ps1
```