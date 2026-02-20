#!/bin/sh
# vim: ts=4: shiftwidth=4

# ----------------------------------------------------------------------
# @file test.sh
# @brief test connectivity to the target host
# ----------------------------------------------------------------------

#__LIBRARY_SOURCE_CODE__

main() {
    echo "--------------------------------------------"
    echo "$(hostname):$(whoami)> TEST"
    echo "--------------------------------------------"
    set -x
    date
    uname -a
    freebsd-version
    /sbin/pfctl -nvf ${DRIST_TEMP_DIR}/new/pf.conf
    /sbin/pfctl -t blocked -T show
    netstat -nr
    zpool status
    zfs list -t snapshot
    zfs list
    zfs mount
    archive_changes test
    set x
    echo "--------------------------------------------"
}

# Call `main()`
main "$@"
