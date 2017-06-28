#!/bin/bash

NEWLIB_PATH=/home/da/dev/toolchain/newlib-2.1.0
LIBGLOSS_PATH=/home/da/dev/toolchain/newlib-2.1.0/arm-eabi/libgloss/arm
LIBNONSYS_PATH=/home/da/dev/toolchain/newlib-2.1.0/arm-eabi/libgloss/libnosys
ARM_TOOLCHAIN_UBER4_8=/home/da/dev/toolchain/arm-eabi-4.8/bin

# Compile stubs
$ARM_TOOLCHAIN_UBER4_8/arm-eabi-gcc -mcpu=cortex-a8 -I $NEWLIB_PATH/newlib/libc/include -c -o syscalls.o syscalls.c

$ARM_TOOLCHAIN_UBER4_8/arm-eabi-as -mcpu=cortex-a8 -o startup.o startup.s

# works fine but does not boot: -Wl,--gc-sections
$ARM_TOOLCHAIN_UBER4_8/arm-eabi-gcc -static -mcpu=cortex-a8 -T test.ld -nostartfiles -lgcc -L$NEWLIB_PATH/arm-eabi/newlib -lg -lc -lm -L$LIBGLOSS_PATH/librdimon.a test.c startup.o syscalls.o -o init -I$NEWLIB_PATH/newlib/libc/include

#- Create ramdisk with cpio utility
#-- Remove the existing ramdisk if exists
if [ -f initramfs ]; then
    rm initramfs
    echo "> Removed existing initramfs"
fi
#-- Create ramdisk with the static program created
echo init|cpio -o --format=newc > initramfs

#- Create executable binary
$ARM_TOOLCHAIN_UBER4_8/arm-eabi-objcopy -O binary init init.bin
