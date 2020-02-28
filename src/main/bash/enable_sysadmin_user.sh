#!/bin/sh
set -o nounset \
    -o errexit \
    +o xtrace

#Load Common Functions    
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/_funcs.sh"

export SYSADMIN_USER="admin"
request_value_if_not_defined "SYSADMIN_USER" $SYSADMIN_USER "What is the User Principal?" ${1-}

#Load Cluster Information
request_cluster_info ${2-}

set -o xtrace

#Let User have SystemAdmin against Kafka
confluent iam rolebinding create --principal User:$SYSADMIN_USER --role SystemAdmin --kafka-cluster-id $KAFKA_CLUSTER

#Let User have SystemAdmin against Kafka Connect Cluster
if [ -z "CONNECT_CLUSTER" ]; then
    confluent iam rolebinding create --principal User:$SYSADMIN_USER --role SystemAdmin --kafka-cluster-id $KAFKA_CLUSTER --connect-cluster-id $CONNECT_CLUSTER
fi

#Let User have SystemAdmin against Schema Registry
if [ -z "SR_GROUP_ID" ]; then
    confluent iam rolebinding create --principal User:$SYSADMIN_USER --role SystemAdmin --kafka-cluster-id $KAFKA_CLUSTER --schema-registry-cluster-id $SR_GROUP_ID
fi