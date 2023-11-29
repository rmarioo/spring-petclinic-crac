#!/bin/bash

# Enable checkpoint compression (will reduce restore time a bit)
#export CRAC_CRIU_OPTS=--compress

START_TIME=$(($(date +'%s * 1000 + %-N / 1000000')))
java -DSTART_TIME=$START_TIME -Dspring.context.checkpoint=onRefresh -XX:CRaCCheckpointTo=./tmp_auto_checkpoint -jar build/libs/spring-petclinic-3.2.0.jar
