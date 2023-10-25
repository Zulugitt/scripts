#!/bin/bash

summary="/tmp/summary.txt"
#
#sumfileO=$(cat $summary | grep -i Succ)
#sumfileW=$(cat $summary | grep -i Warn)



if [ -n "$1" ]; then
inp1=`(echo $PWD)`
else 
inp1=`(echo $1)`
fi

sumfileO=`(ls -la "$1" | grep -Ei dr"(w|-)"x )`
sumfileW=`(ls -la "$1" | grep -Ei -v dr"(w|-)" | grep -vi total) `

TOKEN="Paste_BotNumber:Paste_authToken"
ID_CHAT="Paste_ID"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curlTG=$sumfileO
MESSAGE="$curlTG"
curl -X POST  $URL -d chat_id=$ID_CHAT -d text="$MESSAGE"

curlTG=$sumfileW
MESSAGE="$curlTG"
curl -X POST  $URL -d chat_id=$ID_CHAT -d text="$MESSAGE"


