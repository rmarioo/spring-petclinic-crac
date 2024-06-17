#!/bin/bash

START_TIME=$(($(date +'%s * 1000 + %-N / 1000000')))
java -DSTART_TIME=$START_TIME -jar target/spring-petclinic-3.2.0-SNAPSHOT.jar --spring.profiles.active=mysql
