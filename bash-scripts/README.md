<h1>
Bash User scripts
<img style="filter:invert(1)" align=right height="24" src="data:image/svg+xml;base64,CjxzdmcgaWQ9IkxheWVyXzEiIGRhdGEtbmFtZT0iTGF5ZXIgMSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgNzkuMzcgOTAuNzEiPjxkZWZzPjxzdHlsZT4uY2xzLTF7ZmlsbDojMWIxYjFmO308L3N0eWxlPjwvZGVmcz48dGl0bGU+QkFTSF9sb2dvLXRyYW5zcGFyZW50LWJnLWJ3PC90aXRsZT48cGF0aCBjbGFzcz0iY2xzLTEiIGQ9Ik03My44NSwxOC41MmwtMjguNjQtMTdhMTAuNzksMTAuNzksMCwwLDAtMTEsMGwtMjguNjQsMTdBMTEuNDIsMTEuNDIsMCwwLDAsMCwyOC4zNnYzNGExMS40MiwxMS40MiwwLDAsMCw1LjUyLDkuODRsMjguNjQsMTdhMTAuNzksMTAuNzksMCwwLDAsMTEsMGwyOC42NC0xN2ExMS40MiwxMS40MiwwLDAsMCw1LjUyLTkuODR2LTM0QTExLjQyLDExLjQyLDAsMCwwLDczLjg1LDE4LjUyWk01MS42Nyw3MS42MWwwLDIuNDRhMC45LDAuOSwwLDAsMS0uNDIuNzVsLTEuNDUuODNjLTAuMjMuMTItLjQyLDAtMC40Mi0wLjMybDAtMi40YTQuNzEsNC43MSwwLDAsMS0zLjMuMzIsMC40NCwwLjQ0LDAsMCwxLS4xNi0wLjU0bDAuNTItMi4yMUEwLjkyLDAuOTIsMCwwLDEsNDYuNzMsNzBhMC41OCwwLjU4LDAsMCwxLC4xNC0wLjEsMC4yOSwwLjI5LDAsMCwxLC4yMywwLDQsNCwwLDAsMCwzLS4zOCw0LDQsMCwwLDAsMi4yNC0zLjQzYzAtMS4yNC0uNjgtMS43Ni0yLjMyLTEuNzctMi4wOCwwLTQtLjQtNC4wNS0zLjQ3YTguODksOC44OSwwLDAsMSwzLjM2LTYuOGwwLTIuNDdhMC44OSwwLjg5LDAsMCwxLC40Mi0wLjc2bDEuNC0uODljMC4yMy0uMTIuNDIsMCwwLjQyLDAuMzNsMCwyLjQ3YTQuNTYsNC41NiwwLDAsMSwyLjc0LS4zMywwLjQ0LDAuNDQsMCwwLDEsLjE4LjU3TDU0LDU1LjE2YTAuOTQsMC45NCwwLDAsMS0uMjUuNDQsMC41OCwwLjU4LDAsMCwxLS4xNC4xMSwwLjMzLDAuMzMsMCwwLDEtLjIxLDAsMy42MywzLjYzLDAsMCwwLTIuNjQuNDMsMy4zMiwzLjMyLDAsMCwwLTIsMi45NGMwLDEuMTIuNTksMS40NiwyLjU3LDEuNSwyLjY1LDAsMy43OSwxLjIsMy44MiwzLjg2QTkuNDgsOS40OCwwLDAsMSw1MS42Nyw3MS42MVptMTUtNC4xMWEwLjU3LDAuNTcsMCwwLDEtLjIyLjU1bC03LjI0LDQuNGEwLjIxLDAuMjEsMCwwLDEtLjM0LTAuMjFWNzAuMzdhMC41MiwwLjUyLDAsMCwxLC4zMy0wLjQ2bDcuMTMtNC4yN2EwLjIxLDAuMjEsMCwwLDEsLjM0LjIxVjY3LjVabTUtNDEuODFMNDQuNTcsNDIuNDNjLTMuMzgsMi01Ljg3LDQuMTktNS44Nyw4LjI2Vjg0LjA3YzAsMi40NCwxLDQsMi41LDQuNDhhOC43Nyw4Ljc3LDAsMCwxLTEuNS4xNSw4Ljg3LDguODcsMCwwLDEtNC41Mi0xLjI1bC0yOC42NC0xN0E5LjQyLDkuNDIsMCwwLDEsMiw2Mi4zNnYtMzRhOS40Miw5LjQyLDAsMCwxLDQuNTQtOC4xbDI4LjY0LTE3YTguODMsOC44MywwLDAsMSw5LDBsMjguNjQsMTdhOS4zNiw5LjM2LDAsMCwxLDQuNCw2LjU1Qzc2LjI5LDI0Ljc5LDc0LjE1LDI0LjIzLDcxLjY2LDI1LjY5WiIvPjwvc3ZnPgo=" />
</h1>

_This folder is intended for user scripts written in sh/bash/zsh and used as executables across system._

## Prerequisites
To use this scuffold-toolchain successfully you are assumed to know well the following:
* Unix/Linux: 
* Virtual terminal emulators (KDE Konsole/GNOME terminal)
* Filesystem concepts (path) and commands (e.g. `pwd` etc) 
* Virtual terminal shells, like `sh`, `bash`, `zsh` `etc`.

## Install

To install to `~/.local/bin/` run the `stow` command (see also `.stowrc`):
```
stow .
```
Into your shell `~/.bashrc` or `~/.zshrc` file add:
```sh
#---------------------------------------------------------user-scripts-path-init
# Add user scripts from ~/.bash-scripts/* to system $PATH
#-------------------------------------
if [[ -d "$HOME/.local/bin/" ]];
then
    PATH="${PATH}:$HOME/.local/bin/" 
fi
```

## Overview
| Command name | Description |
|-|-|
| processes-inotify-report.sh | Get the procs sorted by the number of inotify watches |
| term-std | Bash terminfo color constants library; inteded to be sourced |
| unicode-emoji-remove.sh | Unicode tool to strip emoji & icons from textual file |
| kubuntu-setup.sh | Setup various user dev tools under Linux/Kubuntu |
| kubuntu-neovim-config | Script to build / run / install / uninstall Neovim |


## Help
Almost every command supports `-h` or `--help` flags to get help</br>

## See also

* hinell/scaffold
* hinell/devtools

----
June 27, 2023</br>
August 13, 2023</br>
Copyright (C) 2023- Alex A. Davronov <al.neodim@gmail.com></br>
