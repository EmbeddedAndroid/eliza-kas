# Sources of the Eliza EVK images

What each image is built from, all pinned (kas/include/pins.yml and the
recipes of the pinned meta-qcom).

## Layers
| repository | commit |
|---|---|
| github.com/EmbeddedAndroid/meta-qcom (eliza/repro) | kas/include/pins.yml |
| github.com/openembedded/bitbake | 89802bd702d80d6116c47bf44ec876568f71e8dd |
| github.com/openembedded/openembedded-core | c2ea9568b768de7c479aba22f15520793a7dace4 + meta-qcom patches/oe-core 0002-0005 |
| github.com/openembedded/meta-openembedded | 33db795031ddef81949db64aedf33070e1330fdd |
| git.yoctoproject.org/meta-arm | 854b732c4a09a7c004a962ebb94da520a510e8b9 |
| github.com/qualcomm-linux/meta-ai | ec488d7f302c0bccd4a903c0963e9794f4409592 |
| github.com/AudioReach/meta-audioreach | a43b2ad6f731041602302e890da2b8a1d02cd686 |
| github.com/qualcomm-linux/meta-qcom-distro | 3bcf28708c932022dad4858502ceb78a5c0dc43c |
| git.yoctoproject.org/meta-security | 1b3d7d6a49be21fa12b7a64fa343f399c8a9a1a5 + meta-qcom patches/meta-security 0001 |
| git.yoctoproject.org/meta-selinux | 4f812945311e706a7a096863b81243738829c9a7 + meta-qcom patches/selinux 0001-0002 |
| github.com/uptane/meta-updater | 2421cb841e648ef26564d9a2131a0016adc56cbd |
| git.yoctoproject.org/meta-virtualization | 89b00d096a432000766729cd721ae647af500112 |
| this repository | meta-eliza-lab (fingerprint, diagnostics, test configuration) |

## meta-qcom eliza/repro
qualcomm-linux/meta-qcom master 3fee3ada3c49 plus, in order: the
eliza-evk-emmc machine (meta-qcom PR 3382), the audioreach v1.0.5
topology sync (PR 3578), the Eliza open boot firmware machine and recipes
(TF-A, OP-TEE, U-Boot, BL2 signing classes), the oe-selftest argument fix
(PR 3500), the Hexagon DSP packaging series (PR 3227) with mahua, nord and
eliza, then the Eliza EVK commits: U-Boot fastboot fixes, the
linux-qcom-eliza kernel, the machine switch to it, iris_vpu Eliza support,
the AudioReach Eliza sound card, the PAL raw stream, kvmtool ARCH,
tee-supplicant storage, kgsl on open boot firmware, SuperSpeed fastboot,
fastboot getvar platform and unlocked, the kernel update to the OV9282
series and the IMX577 + OV9282 composite in the UKI.

## Kernel
linux-qcom-eliza builds github.com/EmbeddedAndroid/linux eliza/integration
(SRCREV in recipes-kernel/linux/linux-qcom-eliza_git.bb): qcom-next
qcom-next-7.3-20261031 (17bbb4b37bbc) with the meta-qcom linux-qcom-next
fixes, the Eliza EVK boot series, native HDMI, CAMSS with the IMX577
(CAM0) and OV9282 (CAM1) cameras and the q6apm audio fixes. The UKI
carries the eMMC EL2 IMX577 + OV9282 composite DTB. Config: the tree's defconfig, hardening.config,
prune.config and qcom.config, meta-qcom bsp-additions.cfg and
no-smccc-soc-id.cfg.

## Boot firmware
| component | source |
|---|---|
| TF-A BL2 + BL31 | github.com/EmbeddedAndroid/arm-trusted-firmware qcom/eliza-next a3ab19a9db87a7824092dd60b1789fa17772b4a8 |
| OP-TEE + TAs | github.com/EmbeddedAndroid/optee_os qcom/eliza-next 7a8e0bb1a05ac9b0172907d977981a8cf65f32d1 |
| U-Boot | github.com/qualcomm-linux/u-boot 0766fef311064ef58a78282fd92c1eed74aa494b + meta-qcom patches 0001-0024 |
| XBL and the other boot binaries | firmware-qcom-boot-eliza 00014 (docs/binaries.md) |
| CDT | firmware-qcom-cdt-eliza cq7790-evk_v1 (docs/binaries.md) |

BL2 must be QTI signed after the build: docs/signing.md.

## Known source gap
github.com/microsoft/onnxruntime (onnxruntime in both images, meta-ai
SRCREV_ort 8c546c37b43caaca1fa25db430dab94b901cf277) no longer answers;
fetch it from a mirror set in kas/local/mirror.yml until a public mirror
is pinned here.
