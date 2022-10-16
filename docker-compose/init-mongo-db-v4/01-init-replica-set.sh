#!/bin/bash

echo "########### Waiting for primary ###########"
until mongo --host primary  --eval "printjson(db.runCommand({ serverStatus: 1}).ok)"
  do
    echo "########### Sleeping  ###########"
    sleep 5
  done


echo "########### Waiting for replica 01  ###########"
until mongo --host replica01 --eval "printjson(db.runCommand({ serverStatus: 1}).ok)"
  do
    echo "########### Sleeping  ###########"
    sleep 5
  done


echo "########### Waiting for replica 02  ###########"
until mongo --host replica02 --eval "printjson(db.runCommand({ serverStatus: 1}).ok)"
  do
    echo "########### Sleeping  ###########"
    sleep 5
  done

echo "########### All replicas are ready!!!  ###########"

echo "########### Setting up cluster config  ###########"

echo "########### Getting replica set status  ###########"
mongo --host primary -u root -p root --authenticationDatabase admin <<EOF
rs.status()
EOF
echo "########### Initiating replica set ###########"
mongo --host primary -u root -p root --authenticationDatabase admin <<EOF
rs.initiate()
EOF
echo "########### Adding replica01 to replica set ###########"
mongo --host primary -u root -p root --authenticationDatabase admin <<EOF
rs.add("replica01:27017")
EOF

echo "########### Adding replica02 to replica set ###########"

mongo --host primary -u root -p root --authenticationDatabase admin  <<EOF
rs.add("replica02:27017")
EOF

echo "########### Getting replica set status again  ###########"
mongo --host primary -u root -p root --authenticationDatabase admin  <<EOF
rs.status()
EOF

echo "########### Stopping TEMP instance  ###########"
mongod --shutdown


