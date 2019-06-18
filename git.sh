#!/bin/bash
WEB_PATH=$1
WEB_USER='www'
WEB_USERGROUP='www'

cd $WEB_PATH
sudo git pull origin $3

sudo chown -R $WEB_USER:$WEB_USERGROUP $WEB_PATH
