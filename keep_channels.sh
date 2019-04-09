
#!/bin/bash

wget -O /home/$USER/Downloads/tv_channels_plus.m3u "http://sampleiptv.com:1557/get.php?username=xxxxxx&password=xxxxxxx&type=m3u_plus&output=ts"
m3ulist="/home/$USER/Downloads/tv_channels.m3u"
channel_list="/home/$USER/Downloads/tv_channels_plus.m3u"
rm $channel_list

include="UK: USA-CANADA SPORT AUSTRALIA"

for i in $include
do
  echo "$i"
  sed  -n -r -e '/EXTM3U/p' -e "/$i/,+1p" $m3ulist | tee -a $channel_list
done
