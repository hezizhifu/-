#/bin/bash
#monitor http code status
#timer:2017/09/12 
#author:lijian
access_log='/usr/local/nginx/logs/'$2
error_log='/usr/local/nginx/logs/'$2
date=`date -d "1 minutes ago" | awk '{print $4}' | cut -d: -f1,2`
 code_40x(){
 grep $date $access_log | awk -F '"' '{print $3}' | awk '{print $1}' | grep -E '40[0-9]'| grep -v '405'| wc -l
}
 code_50x(){
 grep $date $access_log | awk -F '"' '{print $3}' | awk '{print $1}' | grep -E '50[0-9]' | wc -l
}
 error(){
  grep $date $error_log | egrep -i 'error|no|not|failed|denied' | wc -l  

}
case $1 in 
	code_40x)
		code_40x;;
	code_50x)
		code_50x;;
	error)
		error;;
	*)
		echo "Usage: $0{code_40x|code_50x|error}";;
esac
