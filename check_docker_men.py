#!/usr/bin/env python
#-*- coding:utf-8 -*-
import sys
import docker
from influxdb import InfluxDBClient
Argv=sys.argv[1]
#传参
def check_container_name():
	Doc_conn=docker.Client(base_url='unix://var/run/docker.sock',version='auto',timeout=5)
        Docker_cli=Doc_conn.containers()
	L=[]
	for docs in Docker_cli:
		num=docs['Names'][0]
		strs=num.replace("/","")
		L=L+[strs]
	return L
#检索本机docker client中所有的容器名 container_name
Conn=InfluxDBClient('106.14.237.27',8086,'docker','docker','docker')
#连接并初始化数据库
Res="select mean(usage_percent) from docker_container_mem where container_name=" + "'" + Argv + "'" + " and time>now()- 8h  group by time(60s) fill(none)  order by desc  limit 1"
#查询语句
if Argv in check_container_name():
	Data=Conn.query(Res)
#	#执行查询语句
	for itme in Data:
		print('%.2f'%(itme[0]['mean']))
#		#迭代打印出所需数据,内存使用率usage
else:
	print("not have the '"+ Argv + "' please check once be sure all selected in: ")
	print check_container_name()
