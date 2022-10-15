##!/bin/bash
#
#echo "########### Waiting for primary ###########"
#until mongo --eval "printjson(db.runCommand({ serverStatus: 1}).ok)"
#  do
#    echo "########### Sleeping  ###########"
#    sleep 5
#  done
#
#
#echo "########### Waiting for replica 01  ###########"
#until mongo --host replica01 --eval "printjson(db.runCommand({ serverStatus: 1}).ok)"
#  do
#    echo "########### Sleeping  ###########"
#    sleep 5
#  done
#
#
#echo "########### Waiting for replica 02  ###########"
#until mongo --host replica02 --eval "printjson(db.runCommand({ serverStatus: 1}).ok)"
#  do
#    echo "########### Sleeping  ###########"
#    sleep 5
#  done
#
#echo "########### All replicas are ready!!!  ###########"
#
#echo "########### Setting up cluster config  ###########"
#
#echo "########### Getting replica set status  ###########"
#mongosh --host primary -u root -p root <<EOF
#rs.status();
#rs.initiate();
#rs.add("replica01:27017");
#rs.add("replica02:27017");
#rs.status();
#EOF
#
#
##mongosh  <<EOF
##rs.status()
##EOF
##echo "########### Initiating replica set ###########"
##mongosh  <<EOF
##rs.initiate()
##EOF
##echo "########### Adding replica01 to replica set ###########"
##mongosh <<EOF
##rs.add("replica01:27017")
##EOF
##
##echo "########### Adding replica02 to replica set ###########"
##
##mongosh  <<EOF
##rs.add("replica02:27017")
##EOF
##
##echo "########### Getting replica set status again  ###########"
##mongosh  <<EOF
##rs.status()
##EOF
#
#
#
#
#
#
#
#
#
##mongosh --host primary -u root -p root <<EOF
##rs.status();
##var config = {
##     "_id": "tutorial-cluster",
##     "version": 1,
##     "members": [
##         {
##             "_id": 0,
##             "host": "primary:27017",
##             "priority": 2
##         },
##         {
##             "_id": 1,
##             "host": "replica01:27017",
##             "priority": 1
##         },
##         {
##             "_id": 2,
##            "host": "replica02:27017",
##            "priority": 1
##        }
##     ]
## };
##rs.initiate(config, { force: true });
##EOF
#
##echo "########### Stopping TEMP instance  ###########"
##mongod --shutdown


#  replica-02:
#    container_name: replica-02
#    image: mongo:5.0.5
#    volumes:
#      - ./init-mongo-db/scripts/secondary:/docker-entrypoint-initdb.d
#      - ./init-mongo-db/configs/keys/mongo-replica-set.key:/data/db/mongo-replica-set.key
#      - ./init-mongo-db/configs/mongod.conf:/etc/mongod.conf
#    ports:
#      - "27037:27017"
#    networks:
#      - mongo-cluster-network
#    command:
#    - "--replSet"
#    - "tutorial-cluster"
#    - "--bind_ip_all"