#!/bin/sh -e

DATE="$1"
FLOOR="$2" #optional

EVENT=$(./get_events.sh "$DATE" "$FLOOR")
echo "$1" "$2" "$EVENT"
./subscribe_from_event.sh "$EVENT" &