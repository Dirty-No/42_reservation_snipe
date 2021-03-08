#!/bin/sh

#   ZONE 2 == E1
#   ZONE 5 == TDM

SLOT_LIST=$(curl -S -b cookies.txt 'https://reservation.42network.org/api/me/events?begin_at=1601251200&end_at=1602460800' \
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
