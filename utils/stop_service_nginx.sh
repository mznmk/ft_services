#!/bin/sh

# stop nginx (free port 80)
sudo systemctl stop nginx;

# display nginx status
systemctl status nginx;
