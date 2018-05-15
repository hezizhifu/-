#!/usr/bin/env python
#-*- coding:utf-8 -*-
import sys
from influxdb import InfluxDBClient
Conn=InfluxDBClient('106.14.237.27',8086,'docker','docker','docker')#连接并初始化数据库
Zbx_Items=['max_used_connections','commands_select','commands_delete','commands_update','commands_insert','threads_connected','connections','aborted_clients','aborted_connects','bytes_received','bytes_sent','QPS','threads_running','slow_queries','innodb_data_read','innodb_data_written','open_files']
#定义监控的参数
Argv=sys.argv[1]
Hostnames=['SZVM-APP-JINFEIBIAO-237-27','SZVM-APP-SCHEDULER-208-94']
def check_argv():

	if Argv not in Zbx_Items:
        	return Zbx_Items
		sys.exit()
	else:
		return 1

def check_mysql():
	
	qs="select mean("+ Argv + ")from mysql where host='"+ Hostnames[0]+"' and time <= now() AND time >= now()- 60s"
	res=Conn.query(qs)
	if (res):
		for items in res:
                	return('%.2f'%(items[0]['mean']))
if (check_argv()==1):
	if(check_mysql()):
		print check_mysql()
	else:
		print 'no data return,please check you sql '
else:
	print 'you should choice last one in:'
	print check_argv()

