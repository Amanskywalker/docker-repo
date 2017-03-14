#!/bin/sh

exec chpst -u root /usr/lib/rstudio-server/bin/rserver --server-daemonize off 2>&1
