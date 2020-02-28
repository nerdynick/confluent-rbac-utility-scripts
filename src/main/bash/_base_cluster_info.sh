###########################
# Platform Wide Properties
###########################

#Your dynamicly generated cluster ID
#This ID is generated when the 1st broker comes online for the first time. 
#Currently it is saved in Zookeeper and cached on each broker in their meta.properties file within the data dir
#
#How to find this value:
#   Via MDS:
#      $> confluent cluster describe --url http://KAFKA_HOST:MDS_PORT(Default: 8090)
#   Via Zookeeper Lookup:
#       $> zkCli.sh -server zookeeper-1:2181 ls /brokers/ids

export KAFKA_CLUSTER=EQFXSH20T7Spw8ZZ8rDDSA 

#############################
# Schema Registry Properties
#############################

#Schema Registry Group ID
#This is the Consumer Group ID that your SR cluster is using for coordination.
#The value provided is the default.
#
#How to find this value:
#   Via Properties:
#       schema.registry.group.id
#       kafkastore.group.id
#   Via REST:
#       $> confluent cluster describe --url http://SR_HOST:SR_PORT(Default: 8081)

export SR_GROUP_ID=schema-registry 

#Schema Registry Principal
#This is the User Principal that SR will be using to authenticate against the Confluent Server via SR's Kafka Client
#The value provided is the default used by Ansible for SCRAM & PLAIN SASL Mechanisams

export SR_USER=schema_registry

#Schema Registry's Schema Storage Topic
#This is the topic that the schema registry cluster has been configured against for storing schemas in
#
#How to find this value:
#   Via Properties:
#       kafkastore.topic

export SR_TOPIC=_schemas

#############################
# Kafka Connect Properties
#############################

#Kafka Connect Group ID
#This is the Consumer Group ID that your Connect cluster is using for coordination.
#The value provided is the default.
#
#How to find this value:
#   Via Properties:
#       group.id
#   Via REST:
#       $> confluent cluster describe --url http://CONNECT_HOST:CONNECT_PORT(Default: 8083)

export CONNECT_CLUSTER=connect-cluster

#Kafka Conenct Principal
#This is the User Principal that Connect will be using to authenticate against the Confluent Server via Connect's Kafka Client
#The value provided is the default used by Ansible for SCRAM & PLAIN SASL Mechanisams

export CONNECT_USER=kafka_connect

#Kafka Connect's Config Storage Topic
#The value provided is the default defined by Ansible
#
#How to find this value:
#   Via Properties:
#       config.storage.topic

export CONNECT_CONFIGS_TOPIC=connect-configs

#Kafka Connect's Offsets Storage Topic
#The value provided is the default defined by Ansible
#
#How to find this value:
#   Via Properties:
#       offset.storage.topic

export CONNECT_OFFSETS_TOPIC=connect-offsets

#Kafka Connect's Status Storage Topic
#The value provided is the default defined by Ansible
#
#How to find this value:
#   Via Properties:
#       status.storage.topic

export CONNECT_STATUS_TOPIC=connect-status