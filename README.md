# addMCULib

This PowerShell Scripts does the following things:

- clone McuLib from Github
- remove FreeRTOS: cortex-m33 and risc-v files
- remove MCUXPresso `semihost_hardfault.c` (The project will use the McuLib provided semihost hardfault handler)
- include McuLib Paths into the include Paths of the Eclipse Project
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