#!/bin/sh
set -o nounset \
    -o errexit \
    +o xtrace

#Load Common Functions    
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$DIR/_funcs.sh"

#Load Cluster Information
request_cluster_info ${1-}

if [ -z "CONNECT_CLUSTER" ]; then
    bash "$DIR/setup_connect.sh"
fi

if [ -z "SR_GROUP_ID" ]; then
    bash "$DIR/setup_schema_reg.sh"
fi