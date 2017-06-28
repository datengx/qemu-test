# qemu-test

Test running different versions of kernel using QEMU. This project assumes that you only have a toolchain compiler. The user space library will also be built using the toolchain compiler

### Credit
This project is solely based on the [tutorial](https://balau82.wordpress.com/2010/12/16/using-newlib-in-arm-bare-metal-programs/) created by Balau. The origin tutorial was created around 2010. The programs in this project have been tested on Ubuntu 16.04 using downloaded old version of ARM toolchain (the details regarding how to obtain the toolchain will be discussed in "Prerequisite".).

-----
### Prerequisite
##### Toolchain
The toolchain corresponds to an older version of gcc and can be obtained from [here](https://bitbucket.org/UBERTC/). The one tested in this project is arm-eabi 4.8.

Download arm-eabi-4.8.

##### User space library using Newlib
The user space libraries are constructed using Newlib (version 2.1.0). The source code of Newlib can be obtained from [here](ftp://sourceware.org/pub/newlib/index.html).

Inside Newlib root directory, do the following to configure:
```
./configure --target=arm-eabi --disable-newlib-supplied-syscalls --with-gnu-ld --with-gnu-as --disable-newlib-io-float --disable-werror
```

and build through the following command:
```
make CC_FOR_TARGET="$ARM_TOOLCHAIN_UBER4_8/arm-eabi-gcc" AS_FOR_TARGET="$ARM_TOOLCHAIN_UBER4_8/arm-eabi-as" LD_FOR_TARGET="$ARM_TOOLCHAIN_UBER4_8/arm-eabi-ld" AR_FOR_TARGET="$ARM_TOOLCHAIN_UBER4_8/arm-eabi-ar" RANLIB_FOR_TARGET="$ARM_TOOLCHAIN_UBER4_8/arm-eabi-ranlib"
```

where the `ARM_TOOLCHAIN_UBER4_8` are the folder containing all the toolchain binary. If you download the toolchain using the instruction in the above section, this folder should be arm-eabi-4.8/bin.

The generated libraries will be put in the folder arm-eabi/newlib and arm-eabi/libgloss under the newlib source code root directory.

##### Kernel
Download Linux kernel version 3.2.

Build the kernel following the instruction listed in this [tutorial](https://balau82.wordpress.com/2012/03/31/compile-linux-kernel-3-2-for-arm-and-emulate-with-qemu/). Replacing all the arm-linux-gnueabi- with arm-eabi-.

[more details explaining the process in the tutorial will be added soon]

### Test qemu
Now it is time to test the emulation using qemu. Run
```
build-test.sh
```
in the root directory of this project to generate the bare metal binary program.

Run
```
run-binary.sh
```
to run the program using qemu (emulating an ARM platform).
