rm -rf out/
mkdir out
make clean
make mrproper
export ARCH=arm64
export CROSS_COMPILE=${PWD}/toolchain/bin/aarch64-linux-android-
# 必须要有O=out，否则会没有产物
make O=out sirius_user_defconfig
make -j$(nproc) O=out

# pack anykernel3 zip
mv out/arch/arm64/boot/Image.gz-dtb ./AnyKernel3/
mv out/drivers/staging/qcacld-3.0/wlan.ko AnyKernel3/modules/vendor/lib/modules/qca_cld3_wlan.ko
cd AnyKernel3/
zip -r bootimg.zip *
