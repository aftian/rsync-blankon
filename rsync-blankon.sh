#!/bin/sh
#
NAME="blankon"
REMOTE1="rsync://arsip.blankonlinux.or.id/blankon/"
LOCAL1="/home/aftian/repo/"
RSYNC="/usr/bin/rsync \
--verbose \
--archive \
--recursive \
--links \
--times \
--ignore-errors \
--delay-updates \
--delete-after \
--stats \
--human-readable \
--progress"
PIDFILE=/root/run/rsync-"$NAME".pid


if [ ! -d "$LOCAL1" ]; then
        /bin/mkdir -p $LOCAL1
        fi
        
if [ -f "$PIDFILE" ]; then
        RUNPID=`/bin/cat $PIDFILE`
if /bin/ps -p $RUNPID; then
        /bin/echo "Mirror is already running..."
        exit 1
else
       /bin/echo "Mirror pid found but process dead, cleaning up"
       /bin/rm -f $PIDFILE
fi
else
       /bin/echo "No Mirror Process Detected"
fi

/bin/echo $$ > $PIDFILE

/bin/echo -n "Mirror Started at: "
/bin/date


$RSYNC $REMOTE1 $LOCAL1


/bin/echo -n "Mirror Ended at: "
/bin/date
/bin/rm -f $PIDFILE

