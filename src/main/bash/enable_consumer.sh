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

export RBAC_CONSUMER_GROUP="*"
request_value_if_not_defined "RBAC_CONSUMER_GROUP" $RBAC_CONSUMER_GROUP "What is the Consumer Group?" ${3-}

#Load Cluster Information
request_cluster_info ${4-}

set -o xtrace

#Let User have ResourceOwner against Consumer Group
confluent iam rolebinding create --principal User:$RBAC_USER --role ResourceOwner --kafka-cluster-id $KAFKA_CLUSTER --resource Group:$RBAC_TOPIC

#Let User have DeveloperRead against Kafka Topic
confluent iam rolebinding create --principal User:$RBAC_USER --role DeveloperRead --kafka-cluster-id $KAFKA_CLUSTER --resource Topic:$RBAC_TOPIC