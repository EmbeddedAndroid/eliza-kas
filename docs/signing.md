# Signing TF-A BL2 (tz.mbn)

On Eliza, XBL authenticates the TZ image, which on the open boot firmware
is TF-A BL2, against the Qualcomm test root of trust even with secure boot
disabled. An unsigned, test-signed or OEM-signed tz.mbn is rejected and
the board does not boot. Everything else in the images is built from
source and needs no signature.

The builds therefore leave BL2 signing off
(`QCOM_FIRMWARE_SIGN_ENABLE:pn-trusted-firmware-a-qcom-eliza = "0"`, see
`kas/include/lab.yml`) and the deploy directory carries the unsigned
`trusted-firmware-a-qcom-eliza/bl2.elf`. Signing it needs:

- sectools v2 1.45 or later, with the QTI-REMOTE signing mode;
- access to a Qualcomm signing service with the test SRoT capability
  `srot_test_v6_com0.0_ent3.0_srot_release`;
- the Eliza TZ security profile (not public; sha256
  `91d70cee47194668f4d1d2760d27f5e164fa9e11c86f9b9cb6e810ebbce858cf`).

The signing options used for the images:

    sectools secure-image bl2.elf --outfile tz.mbn --image-id TZ \
        --security-profile <eliza TZ security profile> --qti --sign \
        --signing-mode QTI-REMOTE <capability option> \
        --platform-binding SOC-HW-VER <site specific service options>
    sectools secure-image tz.mbn --validate --qti --image-id TZ \
        --security-profile <eliza TZ security profile>

`tz.mbn --inspect` must show "Test Root: SRoT MBNv7 Image Signing Test
Root CA". Then put it into the flashable tarball:

    tools/pkg-signed.sh \
        build/tmp/deploy/images/eliza-evk-emmc-open-fw/qcom-multimedia-image-eliza-evk-emmc-open-fw.rootfs.qcomflash.tar.gz \
        tz.mbn QCDFP-YYMMDD-NNNN qcom-multimedia-image-QCDFP-YYMMDD-NNNN-signed.qcomflash.tar.gz

To sign inside the build instead, copy `kas/templates/sign-qti-remote.yml.in`
to `kas/local/sign.yml`, fill in the sectools path, the profile directory
and the service options, and add it to the kas command line. The service
options never go into this repository.
