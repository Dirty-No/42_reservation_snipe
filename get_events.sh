#!/bin/sh

# event format : date +"%Y-%m-%dT%H:%M-SZ"
# get current event : date +"%Y-%m-%dT%H:%00-00Z" (seconds & minutes at 0)

#cat "$1" | grep -E "$(date +"%Y-%m-%dT%H:00:00Z")\",\"end_at"


PATTERN=$(printf "\"%s\",\"end_at" "$1")
#echo "$PATTERN"
SLOTS_LIST=$(./get_slots.sh | grep "$PATTERN")

floor_to_zoneid()
{
	# tasty if forest

	if [ "$1" = "E1" ]
 		then ZONE="2"
	fi

	if [ "$1" = "E2" ]
		then ZONE="3"
	fi

	if [ "$1" = "E3" ]
		then ZONE="4"
	fi

	if [ "$1" = "TDM" ]
		then ZONE="5"
	fi

	echo "$ZONE"
}

if [ $# -eq 2 ];
then
	ZONE=$(floor_to_zoneid "$2")
	SLOTS_LIST=$(echo "$SLOTS_LIST" | grep "zone_id\":$ZONE")
	#echo "$SLOTS_LIST"
fi

echo "$SLOTS_LIST" | sed "s/$(date +"%Y")-//g" | grep -Eo event_id\":[0-9][0-9][0-9][0-9][0-9] | sed 's/event_id\"://g'
