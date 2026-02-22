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
    ensure_service_started jail

    # ensure zfs datasets have been created
    ensure_zfs_dataset_created -o canmount=off -o mountpoint=/opt zroot/SAFE

    ensure_zfs_dataset_created -o canmount=off zroot/SAFE/dev
    ensure_zfs_dataset_created -o canmount=off zroot/SAFE/stage
    ensure_zfs_dataset_created -o canmount=off zroot/SAFE/prod

    ensure_zfs_dataset_created zroot/SAFE/dev/file
    ensure_zfs_dataset_created zroot/SAFE/dev/db

    ensure_zfs_dataset_created zroot/SAFE/stage/file
    ensure_zfs_dataset_created zroot/SAFE/stage/db

    ensure_zfs_dataset_created zroot/SAFE/prod/file
    ensure_zfs_dataset_created zroot/SAFE/prod/db

    archive_changes deploy
    echo "--------------------------------------------"
}

# Call `main()`
main "$@"
