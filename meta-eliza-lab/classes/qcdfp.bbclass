# Stamp the build fingerprint QCDFP into every firmware component and the
# rootfs, so the running build can be read back on the console.
QCDFP ??= ""

python () {
    if not d.getVar('QCDFP'):
        bb.fatal('QCDFP must be set: every lab build carries a fresh fingerprint')
}

qcdfp_rootfs_stamp() {
    echo "${QCDFP}" > ${IMAGE_ROOTFS}${sysconfdir}/qcdfp
}
ROOTFS_POSTPROCESS_COMMAND:append = " qcdfp_rootfs_stamp"
