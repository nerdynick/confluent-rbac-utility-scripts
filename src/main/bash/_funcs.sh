#!/bin/sh
export CLUSTER_INFO="$DIR/_base_cluster_info.sh"

check_var_populated(){
    if [ -z "${2-}" ]; then 
        echo $1; 
        exit 1
    fi
}

confirm(){
    read -p "Continue (y/n)?" choice
    case "$choice" in 
      y|Y ) echo "yes";;
      n|N ) exit 0;;
      * ) exit 0;;
    esac
}

check_and_request_value(){
    local __var_to_set=$1
    local __current_value=$2
    local __message=$3
    
    if [ -n "$__current_value" ]; then
        read -p "$__message: " choice
        eval $__var_to_set="'$choice'"
    else
        eval $__var_to_set="'$__current_value'"
    fi
}

request_value(){
    local __var_to_set=$1
    local __default=$2
    local __message=$3
    
    read -p "$__message (Default: $__default): " choice
    if [ -z "$choice" ]; then
        eval $__var_to_set="'$__default'"
    else
        eval $__var_to_set="'$choice'"
    fi
}

request_value_if_not_defined(){
    local __var_to_set=$1
    local __default=$2
    local __message=$3
    local __provided_val=${4-}
    
    if [ -z "$__provided_val" ]; then
        request_value $__var_to_set $__default $__message
    else
        eval $__var_to_set="'$__provided_val'"
    fi
}

request_bool(){
    local __var_to_set=$1
    local __default=$2
    local __message=$3
    local __val=$2
    
    read -p "$__message (Default: $__default)(y/n): " choice
    case "$choice" in 
      y|Y ) eval $__var_to_set="true";;
      n|N ) eval $__var_to_set="false";;
      * ) eval $__var_to_set="'$__default'";;
    esac
}

request_bool_if_not_defined(){
    local __var_to_set=$1
    local __default=$2
    local __message=$3
    local __provided_val=${4-}
    
    if [ -z "$__provided_val" ]; then
        request_bool $__var_to_set $__default $__message
    else
        case "$__provided_val" in 
          y|Y ) eval $__var_to_set="true";;
          n|N ) eval $__var_to_set="false";;
          * ) echo "Can't eval bool"; exit 1;;
        esac
    fi
}

request_cluster_info(){
    request_value_if_not_defined "CLUSTER_INFO" $CLUSTER_INFO "Which Cluster?" ${1-}
    check_var_populated "No Cluster Info Loaded" $CLUSTER_INFO 
    source "$CLUSTER_INFO"
}