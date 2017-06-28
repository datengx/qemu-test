#!/bin/bash

# Run the emulation with bare metal program (without operating system)
qemu-system-arm -M realview-pb-a8 -serial stdio -kernel init.bin -append "console=ttyAMA0"
