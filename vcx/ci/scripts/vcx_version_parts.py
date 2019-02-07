#!/usr/bin/env python
import sys
from toml_utils import extract_version_from_file
from version_utils import get_revision_number
import buildnum

TOML_FILENAME = 'Cargo.toml'
LIBVCX_DIR = 'libvcx'

def major():
    (major, _) = extract_version_from_file(TOML_FILENAME)
    return major

def minor():
    (_, minor) = extract_version_from_file(TOML_FILENAME)
    return minor

def build_number():
    return buildnum.main()

def full_version():
    return "%s.%s.%s-%s" % (major(), minor(), build_number(), get_revision_number())

if __name__  == "__main__":
    if len(sys.argv) < 2:
        print("USAGE: %s path/to/Cargo.toml" % __file__)
        sys.exit(1)

    print(
        {
            "major": lambda: major(),
            "minor": lambda: minor(),
            "build_number": lambda: build_number(),
            "revision_number": lambda: get_revision_number(),
            "full_version": lambda: full_version()

        }[sys.argv[1]]()
    )
