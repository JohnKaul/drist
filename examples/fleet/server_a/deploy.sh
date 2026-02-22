#!/bin/sh
# vim: ts=4: shiftwidth=4

# ----------------------------------------------------------------------
# @file deploy.sh
# @brief deploy and enable config scripts to the 'bastion' server
# ----------------------------------------------------------------------

#__LIBRARY_SOURCE_CODE__

update_pf() {
    echo "/etc/pf.conf has been updated, reloading pf.conf"
    sudo pfctl -f /etc/pf.conf
}

main() {
    echo "--------------------------------------------"
    echo "$(hostname):$(whoami)> DEPLOY"
    echo "--------------------------------------------"

    update_if_changed rc.conf /etc/rc.conf
    update_if_changed pf.conf /etc/pf.conf

    # update /etc/pf.conf IFF it has changed
    compare_files pf.conf /etc/pf.conf update_pf do_nothing

    # ensure required services are started
    ensure_service_started pf
    ensure_service_started sshd

    archive_changes deploy
    echo "--------------------------------------------"
}

# Call `main()`
main "$@"
