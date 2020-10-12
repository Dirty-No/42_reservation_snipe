#!/bin/sh

convert_utf8()
{
	echo "$1"	\
	|	sed 's/%/%25/g'		|	sed 's/\&/%26/g'	|	sed 's/!/%21/g'	\
	|	sed 's/"/%22/g'		|	sed 's/#/%23/g'		|	sed 's/\$/%24/g'	|	sed 's/(/%28/g'		\
	|	sed 's/)/%29/g'		|	sed 's/+/%2B/g'		|	sed 's/,/%2C/g'		| 	sed 's/\//%2F/g'	\
	|	sed 's/:/%3A/g'		|	sed 's/;/%3B/g'		|	sed 's/</%3C/g'		| 	sed 's/=/%3D/g'		\
	|	sed 's/>/%3E/g'		|	sed 's/?/%3F/g'		|	sed 's/@/%40/g'		| 	sed 's/\[/%5B/g'	\
	|	sed 's/]/%5D/g'		|	sed 's/\^/%5E/g'	|	sed 's/`/%60/g' 	|	sed 's/{/%7B/g'		\
	|	sed 's/|/%7C/g'		|	sed 's/}/%7D/g'
}

printf "Login: "
read LOGIN

stty -echo
printf "Password: "
read PASSWORD
stty echo
printf "\n"

echo "" > cookies.txt

TOKEN=$(curl -s -c cookies.txt -b cookies.txt 'https://signin.intra.42.fr/users/sign_in' --compressed)
TOKEN=$(echo "$TOKEN" |  grep csrf-token | sed 's/<meta name="csrf-token" content="//g' | sed 's/" \/>//g')
TOKEN=$(convert_utf8 "$TOKEN")


PASSWORD=$(convert_utf8 "$PASSWORD")

curl -s -c cookies.txt -b cookies.txt 'https://signin.intra.42.fr/users/sign_in' \
--data-raw "utf8=%E2%9C%93&authenticity_token=$TOKEN&user%5Blogin%5D=$LOGIN&user%5Bpassword%5D=$PASSWORD&commit=Sign+in" \
--compressed > /dev/null

CHECK="$(curl -s -b cookies.txt https://profile.intra.42.fr/)"
CHECK=$(echo "$CHECK" | grep "Intra Profile Home")

if [ -z  "$CHECK" ];
	then printf "\e[31mLOGIN : [FAILED]"
	else printf "\e[32mLOGIN : [SUCCESS]"
fi

printf "\e[0m\n"

curl -s -c cookies.txt -b cookies.txt -L 'https://reservation.42network.org/signin' \
  -H 'Connection: keep-alive' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'DNT: 1' \
  -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: navigate' \
  -H 'Sec-Fetch-User: ?1' \
  -H 'Sec-Fetch-Dest: document' \
  -H 'Referer: https://reservation.42network.org/' \
  -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' \
  --compressed > /dev/null
