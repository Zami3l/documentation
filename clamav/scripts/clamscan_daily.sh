#!/bin/bash

# Debug
set -x

log()
{

	STATUS=$1
	MESSAGE=$2
    RESULT=$3

    if [ $# -qt 2 ]; then
        echo "[STATUS] [MESSAGE] [OUTPUT]"
        exit 1
    fi

    DATETIME=`date +%Y%m%d-%Hh%Mm%Ss`

    if [ $STATUS = RUNNING ]; then
        echo -e "$DATETIME - $MESSAGE .... IN PROGRESS"  						    >> ${LOG}
    fi

    if [ $STATUS = HEALTHY ]; then
        echo -e "$DATETIME - $MESSAGE .... OK\n"               					    >> ${LOG}
    fi

    if [ $STATUS = INFECTED ]; then
        echo -e "$DATETIME - $MESSAGE .... INFECTED\n"           					>> ${LOG}

		NBMALWARE=$(echo "$RESULT" | grep Infected | awk -F': ' '{ print$2 }')

		echo -e "=> Malware detected :" 										  	>> ${LOG}
		echo "$RESULT" | awk -v NB=$NBMALWARE -F": " 'FNR<=NB { print $1 }'    		>> ${LOG}
		echo ""                                                         			>> ${LOG}

        MALWAREFOUND=1
    fi

	if [ $STATUS = FAILED ]; then
        echo -e "$DATETIME - $MESSAGE .... FAILED\n"  	         					>> ${LOG}
        echo -e "DETAILS : "    					                                >> ${LOG}
        echo -e "$MESSAGE\n\n"                       					            >> ${LOG}
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
        echo HEALTHY
    elif [ $STATUS = 'RUNNING' ]; then
        echo RUNNING
    elif [ $STATUS -eq 1 ]; then
        echo INFECTED
	else
		echo FAILED
    fi

}
	
# ---------------------------------------------------------------------------------
# VARIABLES
# ---------------------------------------------------------------------------------

SRV="srv-backup"

DATE=`date +%Y%m%d`

MAILFROM=""
MAILDEST=""
MAILSUBJECT="[`hostname`] SCAN CLAMAV from ${SRV}"
MAILSUBJECTOK="[`hostname`] SCAN CLAMAV from ${SRV} - OK"
MAILSUBJECTKO="[`hostname`] SCAN CLAMAV from ${SRV} - INFECTED"

# Syntax : "<FOLDER>|<FOLDER>"
EXCLUDEDIRTOSCAN="run|proc|boot";
DIRTOSCAN="$(ls -d /*/ | grep -Ev $EXCLUDEDIRTOSCAN)"

LOG="/var/log/SCAN-CLAMAV-${DATE}.log"

MALWAREFOUND=0

# ---------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------
# MAIN PROCESS
# ---------------------------------------------------------------------------------
echo "START: "`date +%Y%m%d-%Hh%M`                                     				> ${LOG}
echo ""                                                                				>> ${LOG}
echo "${MAILSUBJECT}"                                                  				>> ${LOG}
echo ""                                                                				>> ${LOG}
echo "# ---------------------------"                                   				>> ${LOG}
echo "#         Scan CLAMAV "                                          				>> ${LOG}
echo "# ---------------------------"                                   				>> ${LOG}
echo ""                                                                				>> ${LOG}

for S in ${DIRTOSCAN}; do

	MESSAGE="Recursive directory scan [$S]"
    log $(check_status RUNNING) "$MESSAGE"
    RESULT=$(clamscan -ri "$S")
	log $(check_status $?) "$MESSAGE" "$RESULT"

done

echo -e "STOP : `date +%Y%m%d-%Hh%M` \n"                                            >> ${LOG}  

if [ $MALWAREFOUND -eq 0 ]; then
    cat ${LOG} | mail -s "${MAILSUBJECTOK}" -r "${MAILFROM}" "${MAILDEST}"
else
    cat ${LOG} | mail -s "${MAILSUBJECTKO}" -r "${MAILFROM}" "${MAILDEST}"
fi 

exit 0
