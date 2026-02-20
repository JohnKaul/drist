#!/bin/sh
# vim: ts=4: shiftwidth=4

# ----------------------------------------------------------------------
# @file diff.sh
# @brief get a diff of the proposed changes
# @run use the mgr.sh script
# ----------------------------------------------------------------------

#__LIBRARY_SOURCE_CODE__

main() {
    echo "--------------------------------------------"
    echo "$(hostname):$(whoami)> DIFF"
    echo "--------------------------------------------"

    show_diff rc.conf /etc/rc.conf
    show_diff pf.conf /etc/pf.conf

    archive_changes diff
    echo "--------------------------------------------"
}

# Call `main()`
main "$@"
