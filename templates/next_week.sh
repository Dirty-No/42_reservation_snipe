#!/bin/bash

YEAR=$(date -dnext-monday +%Y)
MONTH=$(date -dnext-monday +%m)
DAYS=$(seq $(date -dnext-monday +%d) $(date -d"next-monday + 4 days" +%d))
echo YEAR $YEAR
echo MONTH $MONTH
echo DAYS $DAYS
./list_maker.sh $YEAR $MONTH $DAYS
