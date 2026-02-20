#!/bin/sh
# vim: ts=4: shiftwidth=4

# ----------------------------------------------------------------------
# @file changed.sh
# @brief list the changed files
# ----------------------------------------------------------------------

# __LIBRARY_SOURCE_CODE__

main() {
    echo "--------------------------------------------"
    echo "$(hostname):$(whoami)> CHANGED"
    echo "--------------------------------------------"

    has_changes rc.conf /etc/rc.conf
    has_changes pf.conf /etc/pf.conf

    archive_changes changed
    echo "--------------------------------------------"
}

# Call `main()`
main "$@"
