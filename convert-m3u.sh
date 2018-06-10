#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HOSTNAME=$(hostname)
IP=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

WGET=$(which wget)

URL="https://api.init7.net/tvchannels.m3u"

INFILE="Fiber7.TV.m3u"
OUTFILE="Fiber7.TV.$HOSTNAME.m3u"
WWWFILE="Fiber7.TV.emeidi.local.m3u"

WWWPATH="/var/www/html/tv/$WWWFILE"

echo "Downloading current channel list to '$INFILE' ..."

if [ -f "$INFILE" ]
then
    echo "File '$INFILE' found. Deleting it."
    CMD="rm \"$INFILE\""
    echo $CMD
    eval $CMD
    echo ""
fi

CMD="$WGET \"$URL\" -O \"$INFILE\""
echo $CMD
eval $CMD
echo "Done."
echo ""

if [ ! -f "$INFILE" ]
then
    echo "File '$INFILE' not found. Cannot continue."
    exit 1
fi

echo "Converting official channel list to local channel list at '$OUTFILE' ... "

if [ -f "$OUTFILE" ]
then
    echo "File '$OUTFILE' found. Deleting it."
    CMD="rm \"$OUTFILE\""
    echo $CMD
    eval $CMD
    echo ""
fi

SEARCH="udp://@"
REPLACE="http://$IP:4022/udp/"

CMD="sed -e 's,$SEARCH,$REPLACE,g' $INFILE > $OUTFILE"
echo $CMD
eval $CMD
echo "Done."
echo ""

if [ ! -f "$OUTFILE" ]
then
    echo "File '$OUTFILE' not found. Cannot continue."
    exit 1
fi

echo "Copying local channel list to web server ..."
CMD="cp -f \"$OUTFILE\" \"$WWWPATH\""
echo $CMD
eval $CMD
echo "Done."
echo ""

if [ ! -f "$WWWPATH" ]
then
    echo "File '$WWWPATH' not found. Cannot continue."
    exit 1
fi

echo "Done."
echo ""
echo "Please import playlist from http://$IP/tv/$WWWFILE"
echo ""

exit 0
