#!/bin/sh

# Debug
set -x

log()
{

    STATUS=$1
    MESSAGE=$2
    ERROR=$3
    VERSION=$4

    if [ $# -qt 3 ]; then
        echo "[STATUS] [MESSAGE] [ERROR]"
        exit 1
    fi

    DATES=`date +%Y%m%d-%Hh%Mm%Ss`

    if [ $STATUS = RUNNING ]; then
        echo -e "$DATES - $MESSAGE .... IN PROGRESS"            >> ${LOG}
    fi

    if [ $STATUS = SUCCESS ]; then
        echo -e "$DATES - $MESSAGE .... OK\n"                   >> ${LOG}
        echo -e "$VERSION"
    fi

    if [ $STATUS = FAILED ]; then
        echo -e "$DATES - $MESSAGE .... FAILED\n"               >> ${LOG}
        echo -e "DETAILS : "                                    >> ${LOG}
        echo -e "$ERROR\n\n"                                    >> ${LOG}
        GLOBALERROR=$(($GLOBALERROR + 1))
    fi

}

check_status()
{

    STATUS=$1

    if [ $# -eq 0 ]; then
       echo "Missing args" 
       exit 1
    fi

    if [ $STATUS -eq 0 ]; then
        echo SUCCESS
    elif [ $STATUS = 'RUNNING' ]; then
        echo RUNNING
    elif [ $STATUS -ne 1 ]; then
        echo FAILED
    fi

}

check_version()
{

    VERSIONMAIN="$(sudo sigtool --info /var/lib/clamav/main.cvd | grep Version)"
    VERSIONDAILY="$(sudo sigtool --info /var/lib/clamav/daily.cld | grep Version)"
    VERSIONBYTECODE="$(sudo sigtool --info /var/lib/clamav/bytecode.cvd | grep Version)"

    echo "Database [MAIN] $VERSIONMAIN"                       >> ${LOG}
    echo "Database [DAILY] $VERSIONDAILY"                     >> ${LOG}
    echo "Database [BYTECODE] $VERSIONBYTECODE"               >> ${LOG}


}

# ---------------------------------------------------------------------------------
# VARIABLES
# ---------------------------------------------------------------------------------

# Name server
SRV="srv-backup"

DATE=`date +%Y%m%d`

MAILFROM=""
MAILDEST=""
MAILSUBJECT="[`hostname`] UPDATE DATABASE CLAMAV from ${SRV}"
MAILSUBJECTOK="[`hostname`] UPDATE DATABASE CLAMAV from ${SRV} - OK"
MAILSUBJECTKO="[`hostname`] UPDATE DATABASE CLAMAV from ${SRV} - ECHOUE"

GLOBALERROR=0

LOG="/var/log/UPDATE-DATABASE-CLAMAV-${DATE}.log"

# ---------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------
# MAIN PROCESS
# ---------------------------------------------------------------------------------

echo "START: "`date +%Y%m%d-%Hh%M`                                      > ${LOG}
echo ""                                                                 >> ${LOG}
echo "${MAILSUBJECT}"                                                   >> ${LOG}
echo ""                                                                 >> ${LOG}
echo "# ---------------------------"                                    >> ${LOG}
echo "# Mise à jour base de donnée"                                     >> ${LOG}
echo "# ---------------------------"                                    >> ${LOG}


MESSAGE="Mise à jour base de donnée [MAIN]"
log $(check_status RUNNING) "$MESSAGE"
ERROR=$(sudo freshclam --update-db=bytecode --quiet 2>&1)
log $(check_status $?) "$MESSAGE" "$ERROR"

MESSAGE="Mise à jour base de donnée [DAILY]"
log $(check_status RUNNING) "$MESSAGE"
ERROR=$(sudo freshclam --update-db=bytecode --quiet 2>&1)
log $(check_status $?) "$MESSAGE" "$ERROR"

MESSAGE="Mise à jour base de donnée [BYTECODE]"
log $(check_status RUNNING) "$MESSAGE"
ERROR=$(sudo freshclam --update-db=bytecode --quiet 2>&1)
log $(check_status $?) "$MESSAGE" "$ERROR"

echo -e "STOP : $DATES \n"                                              >> ${LOG}
check_version                                                           >> ${LOG}

if [ $GLOBALERROR -eq 0 ]; then
    cat ${LOG} | mail -s "${MAILSUBJECTOK}" -r "${MAILFROM}" "${MAILDEST}"
else
    cat ${LOG} | mail -s "${MAILSUBJECTKO}" -r "${MAILFROM}" "${MAILDEST}"
fi

sleep 3

exit 0

# ---------------------------------------------------------------------------------
