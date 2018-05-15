#已连接客户端的数量
func_connected_clients () {
        /usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3'  info | grep "connected_clients" | awk -F':' '{print $2}'
}


#内存使用量
func_mem_used () {
     MEM_USED=$(/usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep "\<used_memory\>" | awk -F':' '{print $2}')
     awk 'BEGIN{printf "%.2f\n",'$MEM_USED'/1024/1024}'
 
}
#系统分配给redis的内存量
func_mem_rss(){
	MEM_RSS=$(/usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep "\<used_memory_rss\>" | awk -F':' '{print $2}')
	awk 'BEGIN{printf "%.2f\n",'$MEM_RSS'/1024/1024}'
}
#edis 服务器耗费的系统 CPU
func_cpu_sys_used () {
        /usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep "\<used_cpu_sys\>" | awk -F':' '{print $2}'
}
 
#Redis 服务器耗费的用户 CPU
func_cpu_user_userd () {
        /usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep "\<used_cpu_user\>" | awk -F':' '{print $2}'
}
 
#keyspace_hits 查到key的数量
#keyspace_misses 未查到的key数量
#查询key命中率
func_hit_rate () {
        HIT=$(/usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep "keyspace_hits" | awk -F':' '{print $2}')
        MISS=$(/usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep "keyspace_misses" | awk -F':' '{print $2}')
 
        HIT1=`echo $HIT | tr -d '\r'`
        MISS1=`echo $MISS | tr -d '\r'`
        ALL=`expr $HIT1 + $MISS1`
        hit_rate=`echo "scale=2;$HIT1 / $ALL" | bc | awk '{printf "%.2f", $0}'`
        echo $hit_rate
}


#收到的总连接数 
func_total_connections_received () {
/usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep "total_connections_received" | awk -F':' '{print $2}'
}


 
#处理的命令总数
func_total_commands_processed () {
        /usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep "total_commands_processed" | awk -F':' '{print $2}'
}

#db0数据库的key数量 
func_db_keys () {
        /usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep db0 | awk -F'[:=,]+' '{print $3}'
}


#已经过期的key的数量 
func_db_expires () {
        /usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info | grep db0 | awk -F'[:=,]+' '{print $5}'
}
#查看主从状态
func_role_status() {
	/usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info |  grep  "connected_slaves" | awk -F':' '{print $2}'

}
#哨兵状态是否正常
func_sentinel_status(){
	/usr/local/redis/bin/redis-cli -h 10.28.98.15 -p 26379  info Sentinel | tail -1 | awk -F ',' '{print $2}'| cut -d '=' -f 2
} 
func_attempt_conn(){
	/usr/local/redis/bin/redis-cli -h 10.28.98.143 -p 6379  -a 'ogIu590laJnWfPE3' info  | grep rejected_connections | cut -d ':' -f 2
}
case $1 in 
connected_clients)
        func_connected_clients
        ;;
mem_used)
        func_mem_used
        ;;
mem_rss)
	func_mem_rss
	;;
cpu_sys_used)
        func_cpu_sys_used
        ;;
cpu_user_userd)
        func_cpu_user_userd
        ;;
hit_rate)
        func_hit_rate
        ;;
total_connections_received)
        func_total_connections_received
        ;;
total_commands_processed)
        func_total_commands_processed
        ;;
db_keys)
        func_db_keys
        ;;
db_expires)
        func_db_expires
        ;;
role_status)
	func_role_status
	;;
sentinel_status)
	func_sentinel_status
	;;
rejected_connction)
	func_attempt_conn
	;;
*)
        echo "what can i do for you!"
        ;;
esac
exit 0
