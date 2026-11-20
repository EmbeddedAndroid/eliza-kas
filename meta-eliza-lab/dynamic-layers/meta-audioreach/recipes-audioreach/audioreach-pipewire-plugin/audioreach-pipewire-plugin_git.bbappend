FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# A PAL raw record node on the speaker microphones for the AudioReach
# signal tests (needs the meta-qcom plugin patch for "pal.stream.type").
SRC_URI += "file://eliza-pal-raw-mic.conf"

do_install:append() {
    install -Dm 0644 ${UNPACKDIR}/eliza-pal-raw-mic.conf \
        ${D}${datadir}/pipewire/pipewire.conf.d/eliza-pal-raw-mic.conf
}

FILES:${PN} += "${datadir}/pipewire/pipewire.conf.d/eliza-pal-raw-mic.conf"
