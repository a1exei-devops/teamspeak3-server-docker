#!/bin/bash

# Checking if files exist to make sure we're backing up the database to data
if [ ! -f /opt/teamspeak/ts3server.sqlitedb ] && [ -f /data/ts3server.sqlitedb ]
then
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ -f /opt/teamspeak/ts3server.sqlitedb ]
then
    mv /opt/teamspeak/ts3server.sqlitedb /data/ts3server.sqlitedb
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ -f /opt/teamspeak/ts3server.sqlitedb ] && [ -f /data/ts3server.sqlitedb ]
then
    rm /opt/teamspeak/ts3server.sqlitedb
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

if [ ! -f /opt/teamspeak/ts3server.sqlitedb ] && [ ! -f /data/ts3server.sqlitedb ]
then
    touch /data/ts3server.sqlitedb
    ln -s /data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb
fi

# Run the teamspeak server
export LD_LIBRARY_PATH=/opt/teamspeak
cd /opt/teamspeak
PASSWD=$(pwgen -cns1 36)
./ts3server logpath=/data/logs/ license_accepted=1 serveradmin_password=$PASSWD
echo
echo "Server Query Admin Account password!"
echo "loginname= \"serveradmin\", password= ${PASSWD}"
echo
