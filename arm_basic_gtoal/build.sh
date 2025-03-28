#!/bin/bash

BUILD=build

mkdir -p ${BUILD}

# Copy original
cp binaries/ABORIG ${BUILD}


# Build ARM1 flavour

rm -f ${BUILD}/ABARM1*
asasm -Predefine='RRX SETA 0' -From Basic -G -o ${BUILD}/ABARM1.elf
arm-none-eabi-objcopy -O binary ${BUILD}/ABARM1.elf ${BUILD}/ABARM1
arm-none-eabi-objdump -D ${BUILD}/ABARM1.elf > ${BUILD}/ABARM1.log

# Build ARM2 flavour

rm -f ${BUILD}/ABARM2*
asasm -Predefine='RRX SETA 1' -From Basic -G -o ${BUILD}/ABARM2.elf
arm-none-eabi-objcopy -O binary ${BUILD}/ABARM2.elf ${BUILD}/ABARM2
arm-none-eabi-objdump -D ${BUILD}/ABARM2.elf > ${BUILD}/ABARM2.log


# create inf files
for i in ABORIG ABARM1 ABARM2
do
echo -e "\$."${i}"\t1000\t1000" > ${BUILD}/${i}.inf
done

# Make an SSD
pushd ${BUILD}
rm -f ARMBASIC.ssd
beeb blank_ssd ARMBASIC.ssd
beeb putfile ARMBASIC.ssd  ABORIG ABARM1 ABARM2
beeb title ARMBASIC.ssd "ARM1/2 BASIC"
beeb info ARMBASIC.ssd
popd
