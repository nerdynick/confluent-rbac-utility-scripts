#!/bin/sh
set -o nounset \
    -o errexit \
    +o xtrace
    
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/_funcs.sh"

request_cluster_info ${1-}

set -o xtrace

#Let Connect authenticate/authorize
confluent iam rolebinding create --principal User:$CONNECT_USER --role SecurityAdmin --kafka-cluster-id $KAFKA_CLUSTER --connect-cluster-id $CONNECT_CLUSTER

#Let Connect be able to use its Consumer Group
confluent iam rolebinding create --principal User:$CONNECT_USER --role ResourceOwner --resource Group:$CONNECT_CLUSTER --kafka-cluster-id $KAFKA_CLUSTER

#Let Connect be able to use its Topics
confluent iam rolebinding create --principal User:$CONNECT_USER --role ResourceOwner --resource Topic:$CONNECT_CONFIGS_TOPIC --kafka-cluster-id $KAFKA_CLUSTER
confluent iam rolebinding create --principal User:$CONNECT_USER --role ResourceOwner --resource Topic:$CONNECT_OFFSETS_TOPIC --kafka-cluster-id $KAFKA_CLUSTER
confluent iam rolebinding create --principal User:$CONNECT_USER --role ResourceOwner --resource Topic:$CONNECT_STATUS_TOPIC --kafka-cluster-id $KAFKA_CLUSTER