#!/bin/bash

source usbipExportConfig.sh

INDICATOR_FILE_PATH="/tmp/usbip.indicator"

if [[ ! -f $INDICATOR_FILE_PATH ]]
then
    touch $INDICATOR_FILE_PATH
    echo "unbound" > $INDICATOR_FILE_PATH
fi

function dobind() {
    for busid in "${EXPORT_BUSIDS[@]}"
    do
    	sudo usbip bind -b $busid
    done
    echo "bound" > $INDICATOR_FILE_PATH
    sleep 1 
    if [[ $ENABLE_SSH_ON_BIND -eq 1 ]]
    then
    	ssh $SSH_CLIENT powershell Invoke-WmiMethod -Path "Win32_Process" -Name Create -ArgumentList "$REMOTE_SCRIPT_PATH\\attach.bat"
    fi
}

function dounbind() {
    if [[ $ENABLE_SSH_ON_UNBIND -eq 1 ]]
    then
    	ssh $SSH_CLIENT powershell Invoke-WmiMethod -Path "Win32_Process" -Name Create -ArgumentList "$REMOTE_SCRIPT_PATH\\detach.bat"
    fi
    echo "unbound" > $INDICATOR_FILE_PATH
    for busid in "${EXPORT_BUSIDS[@]}"
    do
        sudo usbip unbind -b $busid
    done
    sleep 1
}

if [[ $1 = "bind" ]]
then
    dobind
elif [[ $1 = "unbind" ]]
then
    dounbind
elif [[ $1 = "info" ]]
then
    status=`cat "$INDICATOR_FILE_PATH"`
    case $status in
        "unbound")
            echo " "
            ;;
        "bound")
            echo " "
            ;;
    esac
elif [[ $1 = "toggle" ]]
then
    status=`cat "$INDICATOR_FILE_PATH"`
    case $status in
        "unbound")
            dobind
            ;;
        "bound")
            dounbind
            ;;
    esac
fi
