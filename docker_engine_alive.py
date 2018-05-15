#!/usr/bin/env python
#-*- coding:utf-8 -*-
import os
import docker
try:
        Doc_conn=docker.Client(base_url='unix://var/run/docker.sock',version='auto',timeout=5)
except:
        print 0
else:
        print 1
