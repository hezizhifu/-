#!/bin/bash
 #监控tcp连接状态数 #定义监控项自定义key使用的参数函数

#接收到的syn报文
SYNRECV(){
syn=$(/bin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'SYN-RECV' | awk '{print $2}')
if [ $syn ];then
echo $syn
else
echo 0
fi
}
        
#并发连接数
ESTAB(){
	/bin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'ESTAB' | awk '{print $2}'
}

#确认中断连接请求
FINWAIT1(){
	/bin/ss -ant |awk '{++s[$1]} END {for(k in s) print k,s[k]}' |grep 'FIN-WAIT-1' |awk '{print $2}'
}

#等待连接中断请求
FINWAIT2(){
	/bin/ss -ant |awk '{++s[$1]} END {for(k in s) print k,s[k]}' |grep 'FIN-WAIT-2' |awk '{print $2}'
}

#等待连接中断请求时长
TIMEWAIT(){
	/bin/ss -ant |awk '{++s[$1]} END {for(k in s) print k,s[k]}' |grep 'TIME-WAIT' |awk '{print $2}'
}

#等待原来发向远程的连接中断请求的确认
LASTACK(){
	/bin/ss -ant |awk '{++s[$1]} END {for(k in s) print k,s[k]}' |grep 'LAST-ACK' |awk '{print $2}'
}

#监听来自远方tcp端口的请求
LISTEN(){
	/bin/ss -ant |awk '{++s[$1]} END {for(k in s) print k,s[k]}' |grep 'LISTEN' |awk '{print $2}'
}

#
State(){
        /bin/ss -ant |awk '{++s[$1]} END {for(k in s) print k,s[k]}' |grep 'State' |awk '{print $2}'
}

#等待断开连接数
CLOSE-WAIT(){
        /bin/ss -ant |awk '{++s[$1]} END {for(k in s) print k,s[k]}' |grep 'CLOSE-WAIT' |awk '{print $2}'
}


case $1 in 
	SYNRECV)
		SYNRECV;;
	ESTAB)
		ESTAB;;
	FINWAIT1)
		FINWAIT1;;
	FINWAIT2)
		FINWAIT2;;
	TIMEWAIT)
		TIMEWAIT;;
	LASTACK)
		LASTACK;;
	LISTEN)
		LISTEN;;
	State)
		State;;
	CLOSEWAIT)
		CLOSE-WAIT;;
	*)
		echo "Usage: $0 { SYNRECV | ESTAB | FINWAIT1 | FINWAIT2 | TIMEWAIT | LASTACK | LISTEN |State | CLOSEWAIT }" ;;
esac

