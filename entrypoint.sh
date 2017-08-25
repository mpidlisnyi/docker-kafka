#!/bin/bash

export HEAP_SIZE=${HEAP_SIZE:=`cat /sys/fs/cgroup/memory/memory.limit_in_bytes | awk '{printf("%.0fm\n",($1*0.8)/1024/1024)}'`}
export KAFKA_HEAP_OPTS="-Xmx${HEAP_SIZE} -Xms${HEAP_SIZE}"

if [ $SERVER_PROPERTIES_URL ];
then
        SERVER_PROPERTIES="/server.properties"
        wget -qO ${SERVER_PROPERTIES} ${SERVER_PROPERTIES_URL}
fi

exec ${@}
