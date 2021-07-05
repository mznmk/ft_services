#!/bin/sh

pgrep nginx;
status=$?;
if [ $status -ne 0]; then
	return 1;
fi

pgrep php-fpm7;
status=$?;
if [ $status -ne 0]; then
	return 1;
fi

pgrep telegraf;
status=$?;
if [ $status -ne 0]; then
	return 1;
fi
