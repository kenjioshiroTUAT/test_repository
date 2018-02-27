#!/bin/sh

petalinux-package --force --boot --fsbl ./images/linux/zynq_fsbl.elf --fpga ./images/linux/design_1_wrapper.bit --u-boot
