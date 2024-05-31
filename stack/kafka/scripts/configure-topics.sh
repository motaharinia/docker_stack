#! /bin/bash

function create_topic {
    topic_name="$1"
    kafka-topics --create --topic ${topic_name} --if-not-exists \
      --partitions 1 --replication-factor 1 \
      --bootstrap-server kafka_broker:29092
}

set -eu -o pipefail

if [ $# -lt 1 ]
then
    echo >&2 "yaml file required"
    exit 1
fi

prefix=""
filter=""
topic_name=""

if [ $# -eq 2 ]
then
  filter=$2
fi

while IFS= read -r line
do
    if [[ "${line}" =~ .*"-".* ]]
    then
        if [ "x${filter}" = "x" ] || [[ "${prefix}" =~ "${filter}".* ]]
        then
            topic_name=`echo "${prefix}_${line}" | tr -d '[:\- ]' | tr -s '_' '-'`
            create_topic $topic_name
        fi
    elif [[ "${line}" =~ ' '.* ]]
    then
        prefix="${prefix}_${line}"
    else
        prefix=$line
    fi
done < <(tr -d '\r' < $1)
