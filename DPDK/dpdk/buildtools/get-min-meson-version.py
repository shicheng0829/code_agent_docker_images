#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-3-Clause
# Copyright(c) 2024 Intel Corporation

import os
import re
import sys
from os.path import dirname, realpath, join

# Get the directory where this script is located
script_dir = dirname(realpath(__file__))

# Assuming the script is in buildtools/, the basedir is the parent directory
basedir = dirname(script_dir)

# Construct the path to meson.build
meson_build_path = join(basedir, "meson.build")

# Check if meson.build exists
if not os.path.exists(meson_build_path):
    print(f"Error: meson.build not found at {meson_build_path}", file=sys.stderr)
    sys.exit(1)

with open(meson_build_path) as f:
    keyword = "meson_version_windows" if os.name == "nt" else "meson_version"
    pattern = fr"{keyword}:\s*'>=\s*([0-9\.]+)'"

    for ln in f.readlines():
        if keyword not in ln:
            continue

        ln = ln.strip()
        ver_match = re.search(pattern, ln)
        if not ver_match:
            print(
                f"Meson version specifier not in recognised format: '{ln}'",
                file=sys.stderr,
            )
            sys.exit(1)
        print(ver_match.group(1), end="")
        break