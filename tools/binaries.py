#!/usr/bin/env python3
"""binaries.py <meta-qcom dir> <recipe-name-prefix>...: list the prebuilt
inputs of the given recipes (.bb, .inc and .bbappend files) (name, version, sha256 of every checksummed
SRC_URI entry) as a markdown table, without the fetch URLs."""
import os
import re
import sys

top = sys.argv[1]
prefixes = sys.argv[2:]
rows = []
for root, dirs, files in os.walk(top):
    dirs[:] = [d for d in dirs if d != '.git']
    for f in files:
        if not f.endswith(('.bb', '.inc', '.bbappend')):
            continue
        stem = f.rsplit('.', 1)[0]
        pn = stem.split('_')[0]
        if not any(pn == p or pn.startswith(p) for p in prefixes):
            continue
        pv = stem.split('_')[1] if '_' in stem else ''
        s = open(os.path.join(root, f)).read()
        for name, sha in re.findall(r'SRC_URI\[(?:([\w.-]+)\.)?sha256sum\]\s*=\s*"([0-9a-f]{64})"', s):
            rows.append((pn, pv, name or '-', sha, os.path.relpath(os.path.join(root, f), top)))
print('| recipe | version | SRC_URI name | sha256 | recipe file |')
print('|---|---|---|---|---|')
for r in sorted(rows):
    print('| %s | %s | %s | `%s` | %s |' % r)
