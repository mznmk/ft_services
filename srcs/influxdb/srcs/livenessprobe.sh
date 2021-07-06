#!/bin/sh

pgrep influxd;
status=$?;
if [ $status -ne 0]; then
	return 1;
fi

pgrep telegraf;
status=$?;
if [ $status -ne 0]; then
	return 1;
fi
