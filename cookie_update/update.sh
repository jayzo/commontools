#!/bin/bash
db='mysql -h10.132.1.231 -upano-user -p123456kt -Dkt_pano_crawl'
if [ "platforms.txt" != "$1" ]
then
  echo '只处理platforms.txt作为参数！'
  exit -1
fi
PFILE=$1
while read line
do
	echo $line | grep -q '^#'
	if [ 0 -eq $? ]
	then
		continue
	fi
	loname=`echo $line | awk -F'@' '{print $1}'`
	cookie=`echo $line | awk -F'@' '{print $2}'`
    echo "update da_admin_cookie  set cookie = '$cookie' where loname = '$loname'"
    $db -e  "update da_admin_cookie  set cookie = '$cookie' where loname = '$loname'"
done < $PFILE
