# Brutal DOOM Installer
**Set of scripts for installing/uninstalling**
> This software is under development!

![Brutal DOOM screenshot](screenshot.png)

## Targets
### [*] Main target
- **Making it easier to setup Brutal DOOM on linux**

## How to deal with?
> There is only Arch and Debian based linux support for now!

### Setup:
1. Clone the repository:
```shell
git clone (repo url here)
cd BDInstaller
```
2. Install dialog package:
```shell
# Arch Linux based
sudo pacman -Sy dialog
# Debian based
sudo apt-get update -y && sudo apt-get install -y dialog
```

### Usage:
- To _install_ just type and answer the questions:
```shell
sudo ./setup.sh
```
- To _uninstall_ just type and answer the questions:
```shell
sudo ./uninstall.sh
```

## Platforms
- **Arch Linux based**
- **Debian based (is beeing tested now)**

## TODO
- **Add RHEl based distros support (just edit dependences.sh)**
- **Add ability to run Brutal DOOM with Free DOOM wad**
- **Rewrite using YAD**
