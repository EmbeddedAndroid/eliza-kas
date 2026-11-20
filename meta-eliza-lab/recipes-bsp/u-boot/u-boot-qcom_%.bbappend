# Print the eMMC bus mode U-Boot negotiates on every boot, with the build
# fingerprint, ahead of the reboot-mode preboot.
do_configure:prepend:eliza-evk-emmc-open-fw() {
	grep -q '^preboot=mmc list; mmc dev 0; mmc info' ${S}/board/qualcomm/default.env || \
	sed -i 's/^preboot=/preboot=mmc list; mmc dev 0; mmc info; echo ubtest_mmcinfo_rc$? ${QCDFP}; /' \
		${S}/board/qualcomm/default.env
	grep -q '^preboot=mmc list; mmc dev 0; mmc info' ${S}/board/qualcomm/default.env
}
