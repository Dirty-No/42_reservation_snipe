#!/bin/bash

#ARG 1 == sublist file
#ARG 2 == floor (E1,E2,E3,TDM) (optional)

declare -A sub_array
declare -A bool_array

export size="0"

while read line ; do
    sub_array[$size]="$line"
    bool_array[$size]='false'
    echo size $size ${sub_array[$size]} ${bool_array[$size]}
    size=$(expr $size + 1)
done <<< "$(cat "$1" | sed '/^$/d')"

COND="true"

while [ "$COND" = "true" ];do
echo "loop" "$COND"
    for count in $(seq 0 $size | tr '\n' ' ')
    do
    echo count $count
        if [ "${bool_array[$count]}" = "false" ];
        then
            RETURNED=$(./subscribe_from_date.sh "${sub_array[$count]}" "$2" | tee /dev/tty )
            bool_array[$count]=$(echo "$RETURNED" | grep false\true)
            if [ -z "${bool_array[$count]}" ];
            then
                if [ "$(echo "$RETURNED" | grep 'unique')" ]
                    then bool_array[$count]="true"
                    else bool_array[$count]="false"
                fi
            fi
        fi
    done

    COND="false"

    for count in $(seq 0 $size | tr '\n' ' ')
    do
        if [ "${bool_array[$count]}" = "false" ];
        then
            COND="true"
        fi
    done

done


#    echo "SUBSCRIBING TO $line"
#    ./subscribe_from_date.sh "$line" "$2"