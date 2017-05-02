#!/bin/bash
set -x

chown -R app:app /home/app
su - app -c 'cd ~/webapp; bundle install --deployment'
