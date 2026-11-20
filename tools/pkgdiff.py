#!/usr/bin/env python3
"""pkgdiff.py A B: diff two buildhistory package lists (installed-packages.txt
with name-version-release.arch.rpm/.ipk/.deb lines, or
installed-package-names.txt) with the kernel release and the git hash in
versions normalised, so a rebuild from another kernel revision compares by
package name and real version."""
import re
import sys

KREL = re.compile(r'-7\.\d+\.\d+-g[0-9a-f]{12}(-p\d+)?(-(qcdfp|QCDFP)-\d{6}-\d+)?')
GITV = re.compile(r'\+git(\d+)?\+[0-9a-f]{7,40}')


def parse(line):
    n = KREL.sub('-KREL', line.strip())
    if n.endswith('.rpm'):
        base = n[:-4].rsplit('.', 1)[0]
        name, ver, rel = base.rsplit('-', 2)
        return name, GITV.sub('+gitX', ver + '-' + rel)
    m = re.match(r'(.+?)_([^_]+)_([^_]+)\.(ipk|deb)$', n)
    if m:
        return m.group(1), GITV.sub('+gitX', m.group(2))
    return n, ''


def load(path):
    out = {}
    for line in open(path):
        if line.strip():
            k, v = parse(line)
            out[k] = v
    return out


a, b = load(sys.argv[1]), load(sys.argv[2])
only_a = sorted(set(a) - set(b))
only_b = sorted(set(b) - set(a))
ver = sorted(k for k in set(a) & set(b) if a[k] != b[k])
print('only in A (%d): %s' % (len(only_a), ' '.join(only_a)))
print('only in B (%d): %s' % (len(only_b), ' '.join(only_b)))
print('version differs (%d):' % len(ver))
for k in ver:
    print('  %s %s -> %s' % (k, a[k], b[k]))
