#!/bin/sh
set -o nounset \
    -o errexit \
    +o xtrace

#Load Common Functions    
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/_funcs.sh"

export RBAC_USER="client"
request_value_if_not_defined "RBAC_USER" $RBAC_USER "What is the User Principal?" ${1-}

export RBAC_TOPIC="*"
request_value_if_not_defined "RBAC_TOPIC" $RBAC_TOPIC "What is the Topic?" ${2-}

#Load Cluster Information
request_cluster_info ${3-}

set -o xtrace

#Let User have DeveloperWrite against Kafka
confluent iam rolebinding create --principal User:$RBAC_USER --role DeveloperWrite --kafka-cluster-id $KAFKA_CLUSTER --resource Topic:$RBAC_TOPIC