#!/bin/bash
#===================================================================================
#
# FILE: speedtool.sh
#
# USAGE: speedtool.sh  urls.txt 10 (optional)
#
# DESCRIPTION: measures the average sever response time of urls in milliseconds.
# First parameter specifies a plain text file with urls. Second parameter sets
# the number of runs for each url. The script uses no-cache headers and timestamps
# at the end of each url to invalidate caches like varnish.
#
# OPTIONS: see function ’usage’ below
# REQUIREMENTS: ---
# BUGS: ---
# NOTES: ---
# AUTHOR: Marc Tönsing
# COMPANY: EatSmarter
# VERSION: 1.0
# CREATED: 06.08.2014
# REVISION: 07.08.2014
#===================================================================================

if [ -z "$1" ]
  then
    echo "no url list file supplied."
    exit 1
fi

if [ -z "$2" ]
  then
    RUNS=5
  else
    RUNS=$2
fi

getcURLResponseTime() {
  TIME_TOTAL=$(curl -H "Cache-Control: no-cache" -H "Pragma: no-cache" -g -s -w "%{time_total}\n" -o /dev/null $1 |sed -e "s/,/./g")
  echo ${TIME_TOTAL}
}

timestamp() {
  date +"%s"
}

while read line
do
  TIME_TOTAL=0
  for (( c=1; c<=$RUNS; c++ ))
  do
    RESPONSE_TIME=$(getcURLResponseTime $line\&timestamp=$(timestamp)$c)
    TIME_TOTAL=$(echo $TIME_TOTAL + $RESPONSE_TIME |bc)
  done
  
  average=$(echo "($TIME_TOTAL * 1000) / $RUNS" |bc)
  
  echo $average
done < $1
