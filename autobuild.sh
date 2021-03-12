#!/bin/bash

SCRIPT_FILE="${0##*/}"
LOG_FILE="${SCRIPT_FILE%.*}.log"

## Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

## Functions
log_exit () {
    if [ $1 -eq 0 ]; then
        echo -e "[${GREEN}OK${NOCOLOR}] $2"
    else
        if [ $1 -eq 2 ]; then
            echo -e "[${YELLOW}WARN${NOCOLOR}] $2"
        else
            echo -e "[${RED}ERR${NOCOLOR}] $2"
            exit 1
        fi
    fi
}

# Clean previous builds
git clean -fx
log_exit $? "CLEAN autobuild files ..."

# Restore default Makefile
cp -vf Makefile.am Makefile
log_exit $? "RESTORE Makefile to defaults ..."
sed -i -e 's/^if XDG_CONFIG_AM/ifdef XDG_CONFIG_HOME/' Makefile
log_exit $? "FIX Automake CONDITIONAL ..."
make
log_exit $? "RUN default make (before automake) ..."
read -p "Continue with autoreconf [0] or Stop here to use default Makefile [1] ?" continue
[ ! -z $continue ] || log_exit $? "Read continue ..."
log_exit $continue "CONTINUE ..."

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
log_exit $? "full make (after automake) ..."
