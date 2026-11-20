#!/bin/sh
# repin.sh <meta-qcom commit>: point kas/include/pins.yml at another
# meta-qcom commit (after a rebase or a message rewrite) and show whether
# the layer tree changed. Needs a meta-qcom clone in $MQ (default
# ../meta-qcom) that has the commit on eliza/repro.
set -eu
new=${1:?usage: repin.sh <meta-qcom commit>}
top=$(cd "$(dirname "$0")/.." && pwd)
pins=$top/kas/include/pins.yml
mq=${MQ:-$top/../meta-qcom}
old=$(awk '/^  meta-qcom:/{m=1} m && /^    commit:/{print $2; exit}' "$pins")
[ -n "$old" ] || { echo "no meta-qcom commit in $pins" >&2; exit 1; }
full=$(git -C "$mq" rev-parse "$new^{commit}")
git -C "$mq" merge-base --is-ancestor "$full" eliza/repro ||
	{ echo "$full is not on eliza/repro in $mq" >&2; exit 1; }
if [ "$(git -C "$mq" rev-parse "$old^{tree}" 2>/dev/null)" = "$(git -C "$mq" rev-parse "$full^{tree}")" ]; then
	echo "tree unchanged: $old -> $full"
else
	echo "tree CHANGED: $old -> $full"
	git -C "$mq" diff --stat "$old" "$full" 2>/dev/null | tail -n 1 || true
fi
sed -i "s/^    commit: $old\$/    commit: $full/" "$pins"
grep -q "^    commit: $full\$" "$pins" || { echo "pin not written" >&2; exit 1; }
