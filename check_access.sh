#!/bin/bash

# IP1
CheckHost1="xx.xxx.xxx.xxx"     # Контрольный адрес через основного провайдера, который должен быть доступен при его нормальной работе.
# IP2
CheckHost2="yyy.yyy.yyy.yyy"     # Контрольный адрес через основного провайдера, который должен быть доступен при его нормальной работе.

# IP3
CheckHost3="zzz.zzz.zzz.zzz"     # Контрольный адрес через основного провайдера, который должен быть доступен при его нормальной работе.

NC1="eth0"            # Имя сетевого адаптера основного провайдера
TEST="/tmp/gate.txt"

PasteBotID="ddddddddd"
PasteToken="g6rb&%O*7f5o*&%^OG*&5"
ChatID="oioerioery"


# Наибольший процент потерь до контрольного адреса 
MaxLoss="50"

# Путь к log-файлу
log="/var/log/testISP.log"

####################################### Контроль и переключение #############################################################
# Проверяем контрольный адрес и запоминаем процент потерь
# Проверяем IP1
pgw1=`/bin/ping -c 20 -q -W 3 ${CheckHost1} | /bin/grep loss | /usr/bin/awk '{print $(NF-4)}' | /usr/bin/cut -d"%" -f1`

#Проверяем IP2
pgw2=`/bin/ping -c 20 -q -W 3 ${CheckHost2} | /bin/grep loss | /usr/bin/awk '{print $(NF-4)}' | /usr/bin/cut -d"%" -f1`

#Проверяем IP3
pgw3=`/bin/ping -c 20 -q -W 3 ${CheckHost3} | /bin/grep loss | /usr/bin/awk '{print $(NF-4)}' | /usr/bin/cut -d"%" -f1`

# Пишем в лог, если потери больше нуля

if [ 0 = "${pgw1}" ]
    then
    echo `date +"%d.%m.%Y %T %:z"`. "- Потери до контрольного адреса ${CheckHost1} составили ${pgw1}%" >> ${log}
    :
    else
        echo `date +"%d.%m.%Y %T %:z"`. "- Потери до контрольного адреса ${CheckHost1} составили ${pgw1}%" >> ${log}
fi

if [ 0 = "${pgw2}" ]
    then
    echo `date +"%d.%m.%Y %T %:z"`. "- Потери до контрольного адреса ${CheckHost2} составили ${pgw2}%" >> ${log}
    :
    else
        echo `date +"%d.%m.%Y %T %:z"`. "- Потери до контрольного адреса ${CheckHost2} составили ${pgw2}%" >> ${log}
fi

if [ 0 = "${pgw3}" ]
    then
    echo `date +"%d.%m.%Y %T %:z"`. "- Потери до контрольного адреса ${CheckHost3} составили ${pgw3}%" >> ${log}
    :
    else
        echo `date +"%d.%m.%Y %T %:z"`. "- Потери до контрольного адреса ${CheckHost3} составили ${pgw3}%" >> ${log}
fi


# Проверяем, что процент потерь и если он больше допустимого значения, отсылаем предупреждение на Telegram

if [ "${MaxLoss}" -le "${pgw1}" ]
        then
        echo `date +"%d.%m.%Y %T %:z"`. "- ISP1 down!!! Reason - lost packets for interface ${NC1} to host ${CheckHost1} count ${pgw1}% more ${MaxLoss}%" >> ${log}
	curl -4 "https://api.telegram.org/bot$PasteBotID:$PasteToken/sendMessage?chat_id=$ChatID&text=ISP1_is_down!!!"
fi


if [ "${MaxLoss}" -le "${pgw2}" ]
        then
        echo `date +"%d.%m.%Y %T %:z"`. "- ISP2 down!!! Reason - lost packets for interface ${NC1} to host ${CheckHost2} count ${pgw2}% more ${MaxLoss}%" >> ${log}
#	tail ${log} |grep -i "IPS" > "$TEST"
	curl -4 "https://api.telegram.org/bot$PasteBotID:$PasteToken/sendMessage?chat_id=$ChatID&text=ISP2_is_down!!!"
fi

if [ "${MaxLoss}" -le "${pgw3}" ]
        then
        echo `date +"%d.%m.%Y %T %:z"`. "- ISP3 down!!! Reason - lost packets for interface ${NC1} to host ${CheckHost3} count ${pgw3}% more ${MaxLoss}%" >> ${log}
#	tail ${log} |grep -i "IPS" > "$TEST"
	curl -4 "https://api.telegram.org/bot$PasteBotID:$PasteToken/sendMessage?chat_id=$ChatID&text=ISP3_is_down!!!"
fi


exit
