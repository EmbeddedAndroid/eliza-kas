SUMMARY = "Bind the Adreno GPU without a display subsystem (Eliza EVK lab)"
DESCRIPTION = "The EVK has no display enabled, so the msm GPU component has \
no master to bind to. qcom-next lacks the automatic split from linux-next \
(msm_separate_gpu_kms_auto), so ask for a separate GPU DRM device."
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

do_install() {
    install -d ${D}${sysconfdir}/modprobe.d
    echo "options msm separate_gpu_kms=1" > ${D}${sysconfdir}/modprobe.d/msm-separate-gpu.conf
}

FILES:${PN} = "${sysconfdir}/modprobe.d"
