#!/bin/sh
# vim: ts=4: shiftwidth=4

# ----------------------------------------------------------------------
# @file mgr
# @brief manage deployment
# ----------------------------------------------------------------------

MUNGED_DIR="./_munged"

# TODO: change this to your target server hostname
TARGET="server_a"

display_help(){
	echo "Help"
	echo "h : help"
	echo "c : changed"
	echo "d : diff"
	echo "t : test"
	echo "x : deploy"
	echo "q : quit"
}

prepare_source(){
    mkdir -p ${MUNGED_DIR}
    src_a=$1
    src_b=${MUNGED_DIR}/${src_a}

    rm ${src_b}
    rm ${src_b}-e
    cp ${src_a} ${src_b}

    sed -i -e '/__LIBRARY_SOURCE_CODE__/r ../lib.sh' ${src_b}
}

invoke_rpc(){
    script=$1

    echo "${script}"
    prepare_source ${script} 
    drist -e sudo -p -S ${MUNGED_DIR}/${script} ${TARGET}
    display_help
}

echo "Deploy to ${TARGET}..."
display_help
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
	c)
        invoke_rpc changed.sh
		;;
	x)
        invoke_rpc deploy.sh
		;;
	d)
        invoke_rpc diff.sh
		;;
	t)
        invoke_rpc test.sh
		;;
	q) 	echo "quit ..."
		break
		;;
	h)
		;&
	*)
		display_help
		;;
  esac
done
echo 
echo "done!"

