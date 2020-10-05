#!/bin/sh -e

#good luck figuring out how this works cause im too lazy to explain it

YEAR=$(printf "%.4d" "$1")
MONTH=$(printf "%.2d" "$2")
DAYS=$(echo "${@:3}" | tr ' ' '\n')
TEMPLATE_FILE="subcriptions.template"
LIST_FILE="sublist"
echo "" > "$LIST_FILE"
echo "$DAYS" | while read line ; do
    line=$(printf "%.2d" "$line")
    sed  "s/_DAY_/$line/g" "$TEMPLATE_FILE" | sed  "s/_MONTH_/$MONTH/g" | sed  "s/_YEAR_/$YEAR/g"  >> "$LIST_FILE"
    printf "\n\n" >> "$LIST_FILE"
done