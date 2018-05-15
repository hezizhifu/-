#!/bin/bash
# Script to fetch nginx statuses for tribily monitoring systems
BKUP_DATE=`/bin/date +%Y%m%d`
LOG="/data/log/zabbix/webstatus.log"
HOST="106.14.237.27"
PORT="80"
# Functions to return nginx stats
function active {
/usr/bin/curl -k  "https://$HOST/nginx-status" 2>/dev/null| grep 'Active' | awk '{print $NF}'
}
function reading {
/usr/bin/curl -k  "https://$HOST/nginx-status" 2>/dev/null| grep 'Reading' | awk '{print $2}'
}
function writing {
/usr/bin/curl -k  "https://$HOST/nginx-status" 2>/dev/null| grep 'Writing' | awk '{print $4}'
}
function waiting {
/usr/bin/curl -k  "https://$HOST/nginx-status" 2>/dev/null| grep 'Waiting' | awk '{print $6}'
}
function accepts {
/usr/bin/curl -k  "https://$HOST/nginx-status" 2>/dev/null| awk NR==3 | awk '{print $1}'
}
function handled {
/usr/bin/curl -k  "https://$HOST/nginx-status" 2>/dev/null| awk NR==3 | awk '{print $2}'
}
function requests {
/usr/bin/curl -k  "https://$HOST/nginx-status" 2>/dev/null| awk NR==3 | awk '{print $3}'
}
# Run the requested function
$1
