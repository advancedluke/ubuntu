#!/bin/bash

export JAVA_HOME=
export CATALINA_HOME=

NOW=$(date +"%Y-%m-%d-%H:%M")

export TC_DN_URL="http://apache.tt.co.kr/tomcat/tomcat-connectors/native/1.1.34/source/tomcat-native-1.1.34-src.tar.gz"
export DEBIAN_FRONTEND=noninteractive

# Install Tomcat Native Library 
echo " * Compile Tomcat Native Library "
#sudo apt-get update && sudo apt-get install gcc libapr1 libapr1-dev libtcnative-1 -y
sudo apt-get update && sudo apt-get install build-essential libapr1-dev libssl-dev -y

curl -L -C - -O ${TC_DN_URL}
tar -xvzf tomcat-native-1*.gz
cd tomcat-native-1*/jni/native

./configure -with-apr=`which apr-1-config` -with-java-home=$JAVA_HOME -with-ssl=yes -prefix=$CATALINA_HOME

make
sudo make install

cd ~

# Set setenv.sh
echo " *Add LD_LIBRARY_PATH on ${CATALINA_HOME}/bin/setenv.sh"
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CATALINA_HOME/lib">> setenv.sh
