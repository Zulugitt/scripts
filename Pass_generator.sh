#!/bin/bash 
PWD_LENGTH=8  # длина пароля
SYMBOLS=""
for symbol in {A..Z} {a..z} {0..9}; do SYMBOLS=$SYMBOLS$symbol; done
SYMBOLS=$SYMBOLS'!%*?-+_='
while read LINE; do
    PASS=""
    RANDOM=256
        for i in `seq 1 $PWD_LENGTH`; do
            PASS=$PASS${SYMBOLS:$(expr $RANDOM % ${#SYMBOLS}):1}
    done
    echo -e $LINE '\t' $PASS #>> $2
done #< $1
