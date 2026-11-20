#!/bin/sh
# pkg-signed.sh <qcomflash.tar.gz> <signed tz.mbn> <QCDFP> <out.tar.gz>:
# replace the build's tz.mbn (TF-A BL2) in a meta-qcom qcomflash tarball by
# the QTI signed one, check the fingerprint, write SOURCES.txt.
set -eu
in=$(readlink -f "${1:?qcomflash tarball}") tz=$(readlink -f "${2:?signed tz.mbn}")
fp=${3:?QCDFP} out=${4:?output tarball}
w=$(mktemp -d); trap 'rm -rf "$w"' EXIT
tar -C "$w" -xzf "$in"
[ "$(ls "$w" | wc -l)" = 1 ] || { echo "$in: expected one top directory" >&2; exit 1; }
d=$(ls "$w"); q=$w/$d
[ -f "$q/tz.mbn" ] || { echo "$in has no tz.mbn" >&2; exit 1; }
grep -aq "$fp" "$q/tz.mbn" || { echo "$in: its tz.mbn is not from build $fp" >&2; exit 1; }
grep -aq "$fp" "$tz" || { echo "$tz lacks $fp" >&2; exit 1; }
cp "$tz" "$q/tz.mbn"
for f in tz.mbn uefi.elf; do grep -aq "$fp" "$q/$f" || { echo "$f lacks $fp" >&2; exit 1; }; done
{
	echo "fingerprint $fp, tz.mbn QTI signed after the build"
	echo "base tarball $(basename "$in") sha256 $(sha256sum < "$in" | cut -d' ' -f1)"
	(cd "$q" && sha256sum tz.mbn uefi.elf $(ls rawprogram*.xml patch*.xml 2>/dev/null))
} > "$q/SOURCES.txt"
tar -C "$w" -czf "$out" "$d"
sha256sum "$out"
