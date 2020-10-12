#!/bin/sh

#ARG 1 == dates file
#ARG 2 == floor (E1,E2,E3,TDM) (optional)


cat "$1" | sed '/^$/d' | while read line ; do
echo "SUBSCRIBING TO $line"
./subscribe_from_date.sh "$line" "$2"
echo ""
done
wait
echo ""