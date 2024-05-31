#!/bin/bash

# blocks until kafka is reachable
echo "##########################################################"
echo "Currently available topics:"
kafka-topics --bootstrap-server kafka_broker:29092 --list
echo "##########################################################"

echo "##########################################################"
echo "Reading configured retention policies"
kafka-configs --bootstrap-server kafka_broker:29092 --entity-type brokers --entity-name 1 --all --describe | grep retention
echo "##########################################################"
echo "Creating configured kafka topics"
/scripts/configure-topics.sh $1 $2
echo "##########################################################"
echo -e 'Successfully created the following topics:'
kafka-topics --bootstrap-server kafka_broker:29092 --list
echo "##########################################################"
