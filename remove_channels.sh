#!/bin/bash

wget -O /home/$USER/Downloads/tv_channels_plus.m3u "http://sampleiptv.com:1557/get.php?username=xxxxxx&password=xxxxxxx&type=m3u_plus&output=ts"
m3ulist="/home/$USER/Downloads/tv_channels_plus.m3u"
lines="/home/$USER/Downloads/lines"
touch $lines
channel_list="/home/$USER/Downloads/tv_channels.m3u"
cp $m3ulist $m3ulist.edit

exclude="KOMBETARE LOKALE MUZIKA MACEDONIAN Poland LAJME FEMIJET KS-PORT VIP-ALB FILMA Adults PORTUGAL TURKEY Czech DEUTSCH BRAZIL RUSSIAN SPAIN VOD Islam ISLAM Vod INDIA ARABIAN ROMANIA MALTESE BULGARIAN CHINESE AFRICAN GREEK PAKISTANI HUNGARY AFGHANISTAN ARGENTINA KURDISTAN V0D Slovenia LATINO ALBANIAN SHQIPTARE FETARE GERMANY SWITZERLAND Shqip kultur SWEDEN DENMARK NORWAY Finland NETHERLANDS BELGIUM SHKENCE Deutsch Vendlindja AZERBAIJAN EX-YU Shkokla TURKE ALQUILERO NOUVELLE ISRAELI AUSTRALIA Luxembourg Popcorn Viasat SWEDISH DANISH GERMAN Swiss POLISH SPANISH TRING NOVITA PRIMAFILA KSPORT FINISH NORWEGIAN DUTCh RUSSE SERIALE"

for i in $exclude
do
  while grep -q "$i" "$m3ulist".edit
  do
    grep -n "$i"  "$m3ulist".edit  | awk '{ print $1 }' | sed 's/:#EXTINF:-1/ /g' > $lines
    line_numbers=$(awk -vORS=, '{ print $1 }' $lines | sed 's/,/d;/g')
    echo "Lines containing $i: $line_numbers"
    http_line_numbers=$(awk -vORS=, '{ print $1+1 }' $lines | sed 's/,/d;/g' | sed 's/.$//')
    echo "http_line_numbers: $http_line_numbers"
    sed -i "${line_numbers}${http_line_numbers}" "$m3ulist".edit
  done
done
rm $lines
cp $m3ulist.edit $channel_list
