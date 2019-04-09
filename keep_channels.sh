#!/bin/bash

cd /home/$USER/Downloads/
wget -O /home/$USER/Downloads/tv_channels.m3u "http://sampleiptv.com:1557/get.php?username=xxxxxx&password=xxxxxxx&type=m3u_plus&output=ts"
m3ulist="/home/$USER/Downloads/tv_channels.m3u"
channel_list="/home/$USER/Downloads/tv_channels_plus.m3u"
rm $channel_list

include='UK: USA-CANADA group-title="SPORT" AUSTRALIA'

echo "#EXTM3U" > $channel_list
for i in $include
do
  echo "Keeping $i Channels"
  sed  -n -r -e "/$i/,+1p" $m3ulist | tee -a $channel_list
done
