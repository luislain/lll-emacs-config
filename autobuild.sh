#!/bin/bash

SCRIPT_FILE="${0##*/}"
LOG_FILE="${SCRIPT_FILE%.*}.log"

## Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

## Functions
log_exit () {
    if [ $1 -eq 0 ]; then
        echo -e "[${GREEN}OK${NC}]: $2"
    else
        if [ $1 -eq 2 ]; then
            echo -e "[${YELLOW}WARN${NC}]: $2"
        else
            echo -e "[${RED}ERR${NC}]: $2"
            exit 1
        fi
    fi
}

# Create configure.scan
autoscan -v > $LOG_FILE 2>&1
log_exit $? "Autoscan ..."

# Merge configure.ac
diff configure.ac configure.scan | tee -a $LOG_FILE
log_exit $? "Diff configure.scan ..."
log_exit 2 "Manually merge configure.scan into configure.ac ..."

# Continue after configure.ac merged ?
read -p "Continue [0] or Cancel [1]? : " continue
[ ! -z $continue ] || log_exit $? "Read continue ..."
log_exit $continue "Continue ..."

# Create configure
autoreconf -v -i >> $LOG_FILE 2>&1
log_exit $? "Autoreconf ..."

# Create Makefile
./configure >> $LOG_FILE 2>&1
log_exit $? "Configure ..."

# Make default target
make
log_exit $? "Make ..."
