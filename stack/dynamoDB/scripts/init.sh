#!/bin/bash
cd /scripts/ || exit
# -- > Create DynamoDb Table
echo Creating  DynamoDb tables ...
export AWS_ACCESS_KEY_ID="XXX"
export AWS_SECRET_ACCESS_KEY="XXX"
export AWS_SESSION_TOKEN="XXX"

COMMAND_STATUS=1
until [ $COMMAND_STATUS -eq 0 ]; do
  aws dynamodb create-table --cli-input-json file://table1.json --endpoint-url http://dynamodblocal:8000 --region eu-central-1
  COMMAND_STATUS=$?
  # 0 is success and 254 is "already exists"
  if [ $COMMAND_STATUS -eq 0 ] || [ $COMMAND_STATUS -eq 254 ];
  then
    echo Success \($COMMAND_STATUS\)
    COMMAND_STATUS=0
  else
    echo Retrying in 5 seconds
    sleep 5
  fi
done

# --> List DynamoDb Tables
echo Listing tables ...
aws dynamodb list-tables --endpoint-url http://dynamodblocal:8000 --region eu-central-1
