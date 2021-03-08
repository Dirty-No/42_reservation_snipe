#!/bin/sh

#   ZONE 2 == E1
#   ZONE 5 == TDM

#START_DATE=$(date +%s)
#END_DATE=$(expr "$START_DATE" + 1209600)
START_DATE="0"
END_DATE="2147483647"
 # getting all reservation slots, this will  die on 03:14:07 UTC on 19 January 2038, a.k.a Epochalypse
SLOT_LIST=$(curl -S -s -b cookies.txt "https://reservation.42network.org/api/me/events?begin_at=$START_DATE&end_at=$END_DATE" \
  -H 'Connection: keep-alive' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36' \
  -H 'DNT: 1' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  -H 'Referer: https://reservation.42network.org/' \
  -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' \
  --compressed)

echo "$SLOT_LIST" | sed 's/,{/,#{/g' | tr '#' '\n'
