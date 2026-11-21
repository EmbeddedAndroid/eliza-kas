#!/bin/sh
# new-fp.sh QCDFP-YYMMDD-N: write kas/local/fp.yml with this build's
# fingerprint. Refuses any fingerprint this checkout used before, and any
# that does not come after the last one, by date then number
# (kas/local/fp-used.txt).
set -eu
fp=${1:?usage: new-fp.sh QCDFP-YYMMDD-N}
echo "$fp" | grep -Eq '^QCDFP-[0-9]{6}-[0-9]+$' || { echo "bad fingerprint: $fp" >&2; exit 1; }
top=$(cd "$(dirname "$0")/.." && pwd)
mkdir -p "$top/kas/local"
used=$top/kas/local/fp-used.txt
touch "$used"
if grep -qx "$fp" "$used"; then
	echo "$fp was used before: every build needs a new one" >&2
	exit 1
fi
key() { awk -F- '{ printf "%s %012d\n", $2, $3 }'; }
last=$(key < "$used" | LC_ALL=C sort | tail -n 1)
cur=$(echo "$fp" | key)
if [ -n "$last" ] && [ "$(printf '%s\n%s\n' "$last" "$cur" | LC_ALL=C sort -u | tail -n 1)" = "$last" ]; then
	echo "$fp does not come after the last fingerprint QCDFP-$(echo "$last" | awk '{ print $1 "-" $2 + 0 }')" >&2
	exit 1
fi
sed "s/@QCDFP@/$fp/" "$top/kas/templates/fp.yml.in" > "$top/kas/local/fp.yml"
echo "$fp" >> "$used"
echo "$top/kas/local/fp.yml: $fp"
