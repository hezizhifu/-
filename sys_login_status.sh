#!/bin/bash
#Script to monitor the system LOGIN log
#Author:lijian;time:2017/07/26
#Frist Release

Log_file="/var/log/auth.log"
if [ -f $Log_file ]
  then
     Key=$(egrep '(Failed|Accepted)' $Log_file | awk '{print $3}'| tail -1)
     echo $Key
     if [ $(date +%T -d '5 minutes ago') -gt $Key ]
       then
      echo 'ok!'
    fi
    
fi
     
