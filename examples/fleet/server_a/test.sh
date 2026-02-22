#!/bin/sh
# vim: ts=4: shiftwidth=4

# ----------------------------------------------------------------------
# @file test.sh
# @brief test connectivity to the target host
# @run drist -S /path/to/script/script ACME
# ----------------------------------------------------------------------

#__LIBRARY_SOURCE_CODE__

main() {
    echo "--------------------------------------------"
    echo "$(hostname):$(whoami)> TEST"
    echo "--------------------------------------------"
    date
    uname -a
    freebsd-version
    archive_changes test
    echo "--------------------------------------------"
}

# Call `main()`
main "$@"
