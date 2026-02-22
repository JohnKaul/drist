# ---[ GLOBALS ]--------------------------------------------------
DRIST_BACKUP_DIR="/var/backups/drist"
# TODO: change this to your user, rather than $HOME or $USER
DRIST_USER_DIR="/home/user"
DRIST_TEMP_DIR="${DRIST_USER_DIR}/_drist"

# ---[ LIBRARY HELPERS ]--------------------------------------------------

# archive_changes
#
# copy the local drist files to a backup directoyr. do this instead of
# deleting the local drist files b/c it removes the possibility of
# deleting too much on the target system.
archive_changes() {
  mkdir -p ${DRIST_BACKUP_DIR}
  prefix=$1

  if [ ! -d ${BACKUP_DIR} ]; then
    mkdir -p ${BACKUP_DIR}
  fi
  mv ${DRIST_TEMP_DIR} ${DRIST_BACKUP_DIR}/${prefix}-bak-$(TZ=America/Los_Angeles date -Iseconds)
}

# compare_files
#
# a generic function to campare files and invoke either the on_changed_func or the on_same_func.
# remember the order:
#   * the on_changed_func is FIRST!
#   * the on_same_func is SECOND!
compare_files() {
  file_a=$1             # the file name for the file in the DRIST_TEMP_DIR/new directory
  path_b=$2             # fully qualified path to the target file in the target file system
  on_changed_func=$($3) # a function to invoke when the files are different
  on_same_func=$($4)    # a function to invoke when the files are the same

  path_a=${DRIST_TEMP_DIR}/new/${file_a}
  changes="$(cmp ${path_a} ${path_b})"

  if [ "$?" = "0" ]; then
    # cmp exit code is 0, no changes detected
    $on_same_func
  else
    # cmp exit code is NOT 0, changes detected
    $on_changed_func
  fi
}

# do_nothing
#
# a placeholder function that does nothing. useful for the compare_files function
do_nothing() {
}

# has_changes
#
# display brief change info for changed files. for deeper file introspection,
# use the show_diff() method.
has_changes() {
  file_a=$1
  path_b=$2

  path_a=${DRIST_TEMP_DIR}/new/${file_a}

  changes="$(cmp ${path_a} ${path_b})"

  if [ "$?" != "0" ]; then
    echo "${path_b} : $changes"
  else
    echo "${path_b} : no changes"
  fi
}

# update_if_changed
#
# copy the src file over the target file IFF the src file differs
# from the target file.
update_if_changed() {
  file_a=$1
  path_b=$2

  path_a=${DRIST_TEMP_DIR}/new/${file_a}

  changes="$(cmp ${path_a} ${path_b})"

  if [ "$?" != "0" ]; then
    echo "updating: ${file_a} -> ${path_b}"
    cp ${path_b} ${DRIST_TEMP_DIR}/bak/
    cp ${path_a} ${path_b}
  else
    echo "skipping: ${file_a}"
  fi
}

# show_diff
#
# show the diff between two files
show_diff() {
  file_a=$1
  path_b=$2

  path_a=${DRIST_TEMP_DIR}/new/${file_a}

  changes="$(cmp ${path_a} ${path_b})"

  if [ "$?" != "0" ]; then
    echo "++++++++++++++++++++++++++++++++++++++++"
    echo ${path_b}
    diff ${path_b} ${path_a}
    echo "++++++++++++++++++++++++++++++++++++++++"
  fi
}

# ensure_service_started
#
# TODO: this is pretty rough and could probably be much better.
# The intent is to start a service if it hasn't been started yet.
ensure_service_started() {
  service_name=$1

  result=$(service ${service_name} status | grep -i -E '(enabled|running)')
  if [ "$?" != "0" ]; then
    echo "service ${service_name} not enabled, starting..."
    result2=$(service ${service_name} start)
    if [ "$?" != "0" ]; then
      echo "error starting service: ${service_name}"
      echo $result2
    else
      echo "service ${service_name} started"
    fi
  else
    echo "service ${service_name} already started"
  fi
}

# ensure_service_stopped
#
# TODO: this is pretty rough and could probably be much better.
# The intent is to start a service if it hasn't been stopped yet.
ensure_service_stopped() {
  service_name=$1

  result=$(service ${service_name} status | grep -i -E '(enabled|running)')
  if [ "$?" = "0" ]; then
    echo "service ${service_name} enabled, stoping..."
    result2=$(service ${service_name} stop)
    if [ "$?" != "0" ]; then
      echo "error stopping service: ${service_name}"
      echo $result2
    else
      echo "service ${service_name} stopped"
    fi
  else
    echo "service ${service_name} already stopped"
  fi
}

# ensure_zfs_dataset_created
#
# pass in the same arguments you would pass to 'zfs create' (minus the zfs create)
ensure_zfs_dataset_created() {
  dataset=$(echo $* | sed 's/^.*zroot/zroot/')

  result=$(zfs mount | grep $dataset)
  if [ "$?" != "0" ]; then
    echo "creating dataset $dataset"
    zfs create "$@"
  else
    echo "dataset exists: $dataset"
  fi
}

# ---[ HELPERS ]--------------------------------------------------
