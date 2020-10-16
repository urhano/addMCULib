# addMCULib

This PowerShell Scripts does the following things:

- clone _McuLib_ from [Github](https://github.com/ErichStyger/McuOnEclipseLibrary)
- remove FreeRTOS: `cortex-m33` and `risc-v` files
- remove MCUXPresso `semihost_hardfault.c` (The project will use the _McuLib_ provided semihost hardfault handler)
- include _McuLib_ Paths into the include Paths of the Eclipse Project
- set up `IncludeMcuLibConfig.h` from the provided Template for usage with NXP K22 Microcontrollers


## Warnings

Be sure to have included the following SDK Components:
- gpio
- port
- sim (for K22)
- iap (for LPC)

## Usage

1. copy 'create.ps1' and 'runme_WIN.cmd' into MCUXpresso generated Project root folder
2. run 'runme_WIN.cmd'
3. Profit!

## TODO

- change deletion of `cortex-m33` and `risc-v` files to excluding them in the project
- add a POSIX compatible shell-script for usage under GNU/Linux and macOS using `sed`
- implement check if McuOnEclipseLibrary and McuLib exist already