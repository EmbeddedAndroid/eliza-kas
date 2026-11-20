# Eliza EVK images from source

kas manifests that build the two Eliza CQS EVK (eMMC) images with open boot
firmware from public sources, every repository pinned to a commit:

| | kas file | image |
|---|---|---|
| config #1 | `kas/eliza-evk-open-fw-multimedia.yml` | qcom-multimedia-image: TF-A, OP-TEE, U-Boot and the kernel from source, open GPU stack (drm/msm, Mesa freedreno) |
| config #2 | `kas/eliza-evk-open-fw-proprietary.yml` | qcom-multimedia-proprietary-image: config #1 plus the Qualcomm proprietary userspace (kgsl and Adreno GLES, camx, QAIRT, fastcv), without the lab's separate msm GPU device |

The board support is in the EmbeddedAndroid meta-qcom fork, branch
`eliza/repro` (machine `eliza-evk-emmc-open-fw`, kernel recipe
`linux-qcom-eliza`). This repository only adds the pins
(`kas/include/pins.yml`), a lab layer (`meta-eliza-lab`: build fingerprint
in every firmware component, the kernel release and `/etc/qcdfp`, a U-Boot
eMMC diagnostic, test configuration) and the test tools the board suites
run (`kas/include/lab.yml`). What is built from where: `docs/sources.md`.

## Build

Host: Linux with Docker (or Podman), about 200 GB free for one image and
its sstate. The toolchain is the kas 5.5 container.

    git clone https://github.com/EmbeddedAndroid/eliza-kas.git
    cd eliza-kas
    curl -fsSLo kas-container https://raw.githubusercontent.com/siemens/kas/5.5/kas-container
    chmod +x kas-container

    export DL_DIR=$HOME/yocto/downloads SSTATE_DIR=$HOME/yocto/sstate
    mkdir -p "$DL_DIR" "$SSTATE_DIR"

    # every build gets a new fingerprint
    tools/new-fp.sh QCDFP-YYMMDD-NNNN

    # config #1
    ./kas-container build kas/eliza-evk-open-fw-multimedia.yml:kas/local/fp.yml
    # config #2 (new fingerprint first)
    ./kas-container build kas/eliza-evk-open-fw-proprietary.yml:kas/local/fp.yml

kas-container 5.5 runs `ghcr.io/siemens/kas/kas:5.5` and passes `DL_DIR`
and `SSTATE_DIR` into the container. Optional builder-local fragments go in
`kas/local/` (ignored by git) and are appended to the command line with
`:`; templates in `kas/templates/`:

| template | for |
|---|---|
| `builder.yml.in` | thread counts for the build machine |
| `mirror.yml.in` | a builder-local source mirror (PREMIRRORS) |
| `sign-qti-remote.yml.in` | QTI signing of TF-A BL2 inside the build |

The output is in `build/tmp/deploy/images/eliza-evk-emmc-open-fw/`:
`<image>-eliza-evk-emmc-open-fw.rootfs.qcomflash.tar.gz` (flashable with
qdl, see meta-qcom docs/flashing.md) plus the UKI, the DTBs and
`trusted-firmware-a-qcom-eliza/`.

## Before flashing: sign BL2

XBL only boots a TF-A BL2 (tz.mbn) signed against the Qualcomm test root
of trust. The build leaves it unsigned; sign it and swap it into the
tarball as described in `docs/signing.md` (`tools/pkg-signed.sh`). This is
the only step that needs non-public tools.

## Prebuilt inputs and gaps

Every prebuilt binary is fetched by the pinned recipes and checked against
its sha256: `docs/binaries.md`. Neither config needs a private fetch
location or a credential.

Known gap: github.com/microsoft/onnxruntime, which both images build, no
longer answers. Until a public mirror is pinned here, point
`kas/local/mirror.yml` at a mirror that holds meta-ai's onnxruntime
revision.

## Checking a build

- The fingerprint: `cat /etc/qcdfp` and `uname -r` on the board, TF-A and
  OP-TEE banners and the U-Boot version on the console.
- Package lists: `tools/pkgdiff.py A/installed-packages.txt
  B/installed-packages.txt` on two buildhistory image directories
  (`build/buildhistory/images/eliza_evk_emmc_open_fw/glibc/<image>/`),
  with the kernel release normalised.

## Repository rules

`tools/scrub.sh` runs in CI and before every push: no internal hosts,
addresses, ticket links, signing service details or secrets in this
repository. After a meta-qcom rebase, `tools/repin.sh <commit>` moves the
pin and says whether the layer tree changed.
