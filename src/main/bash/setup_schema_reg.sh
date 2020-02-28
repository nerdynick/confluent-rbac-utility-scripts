#!/bin/sh
set -o nounset \
    -o errexit \
    +o xtrace

#Load Common Functions    
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/_funcs.sh"

#Load Cluster Information
request_cluster_info ${1-}

#Check if Anon ReadOnly should be enabled
export SR_ENABLE_ANON="true"
request_bool_if_not_defined "SR_ENABLE_ANON" $SR_ENABLE_ANON "Enable Anonymous Read-Only Access to all Subjects?" ${2-}

set -o xtrace


#Let SR authenticate/authorize
confluent iam rolebinding create --principal User:$SR_USER --role SecurityAdmin --kafka-cluster-id $KAFKA_CLUSTER --schema-registry-cluster-id $SR_GROUP_ID

#Let SR be able to use its Consumer Group
confluent iam rolebinding create --principal User:$SR_USER --role ResourceOwner --kafka-cluster-id $KAFKA_CLUSTER --resource Group:$SR_GROUP_ID

#Let SR be able to use its Topic
confluent iam rolebinding create --principal User:$SR_USER --role ResourceOwner --kafka-cluster-id $KAFKA_CLUSTER --resource Topic:$SR_TOPIC 

#Setup Anonymous Read Only Access for SR
#This does require SR to be configured for Anonymous Principals via 2 properties
#
#SR Properties:
#   confluent.schema.registry.anonymous.principal: "true"
#   authentication.skip.paths: "/*"
if [ "$SR_ENABLE_ANON" = "true" ]; then
    confluent iam rolebinding create --principal User:ANONYMOUS --role DeveloperRead  --kafka-cluster-id $KAFKA_CLUSTER --schema-registry-cluster-id $SR_GROUP_ID --resource Subject:*
fi