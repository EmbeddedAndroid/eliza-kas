#!/bin/sh
# new-fp.sh QCDFP-YYMMDD-NNNN: write kas/local/fp.yml with this build's
# fingerprint. Refuses any fingerprint this checkout used before, and any
# number not above the last one (kas/local/fp-used.txt).
set -eu
fp=${1:?usage: new-fp.sh QCDFP-YYMMDD-NNNN}
echo "$fp" | grep -Eq '^QCDFP-[0-9]{6}-[0-9]{4}$' || { echo "bad fingerprint: $fp" >&2; exit 1; }
top=$(cd "$(dirname "$0")/.." && pwd)
mkdir -p "$top/kas/local"
used=$top/kas/local/fp-used.txt
touch "$used"
if grep -qx "$fp" "$used"; then
	echo "$fp was used before: every build needs a new one" >&2
	exit 1
fi
last=$(sed 's/.*-//; s/^0*//' "$used" | sort -n | tail -n 1)
n=$(echo "${fp##*-}" | sed 's/^0*//')
if [ -n "$last" ] && [ "${n:-0}" -le "$last" ]; then
	echo "$fp is not above the last fingerprint number $last" >&2
	exit 1
fi
sed "s/@QCDFP@/$fp/" "$top/kas/templates/fp.yml.in" > "$top/kas/local/fp.yml"
echo "$fp" >> "$used"
echo "$top/kas/local/fp.yml: $fp"
