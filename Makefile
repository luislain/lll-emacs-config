# Makefile.am --- Makefile automake configuration file

# Copyright (C) 2020 luislain.com

# Maintainer: lll@luislain.com
# Keywords: config
# Package: lll-emacs-config

# This file is NOT part of GNU Emacs.

# This file is part of EMaCS.

# Emacs Make and Configuration System (EMaCS) is free software; you can
# redistribute it and/or modify it under the terms of the GNU General
# Public License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.

# Emacs Make and Configuration System (EMaCS) is distributed in the hope
# that it will be useful, but WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with EMaCS.  If not, see <http://www.gnu.org/licenses/>.

ifdef XDG_CONFIG_HOME
	export XDG_DIR_EMACS = ${XDG_CONFIG_HOME}/emacs
else
	export XDG_DIR_EMACS = ${HOME}/.config/emacs
endif

LLL_FILE_USER		= "init-user.el"
LLL_FILE_USER_BACKUP	= "init-user-backup.el"
LLL_FILE_DEBUG		= "./src/init-debug.el"

LLL_FILE_INIT		= "./src/init.el"
LLL_FILE_FIRST_RUN	= "./src/init-first-run.el"
LLL_FILE_PROFILE	= "./src/init-profile.el"
LLL_FILE_PACKAGES	= "./src/init-packages.el"

LLL_FILE_SOURCES	= "./src/init-sources.el"
LLL_FILE_DEV		= "./src/init-dev.el"

LLL_FILE_TEST		= "./src/init-test.el"

.PHONY: help install-data-init install-data-debug

# RECURSIVE Targets: all check clean info install-exec install-data
all-local: help

# TODO: Make help rule recursive
help:
	@echo 'Help message'
	@echo '  help			- This message $(XDG_DIR_EMACS).'
	@echo 'Targets:'
	@echo '  check-local		- Search for emacs init file.'
	@echo '  info-local		- Show user local emacs files.'
	@echo '  clean-local		- Undo previous installation.'
	@echo '  install-exec-local	- Git clone GNU Emacs.'
	@echo '  install-data-local	- Copy init file and custom files.'
	@echo '  install-data-init	- Copy only init.el file to .emacs or init.el.'
	@echo '  install-data-debug	- Copy debug file.'

check-local:
	GIT_BRANCH_SH=$$(git name-rev --name-only HEAD); \
	echo "Git Branch: $${GIT_BRANCH_SH}"; \
	git status -s

	@if [ -f $$HOME/.emacs ]; then \
		echo "($$HOME/.emacs) init file FOUND\
			will be renamed to ($$HOME/$(LLL_FILE_USER_BACKUP))"; fi
	@if [ -f $$HOME/.emacs.el ]; then \
		echo "($$HOME/.emacs.el) init file FOUND\
			will be renamed to ($$HOME/$(LLL_FILE_USER_BACKUP))"; fi
	@if [ -f $$HOME/.emacs.d/init.el ]; then \
		echo "($$HOME/.emacs.d/init.el) init file FOUND\
			will be renamed to ($$HOME/.emacs.d/$(LLL_FILE_USER_BACKUP))"; fi
	@if [ -f $(XDG_DIR_EMACS)/init.el ]; then \
		echo "($(XDG_DIR_EMACS)/init.el) init file FOUND\
			will be renamed to ($(XDG_DIR_EMACS)/$(LLL_FILE_USER_BACKUP))"; fi
	@ls -la $(LLL_FILE_INIT)

info-local:
	@echo "INFO LOCAL FILES ..."
	@find $$HOME -maxdepth 3 -name ?emacs*
	@find $$HOME -maxdepth 3 -name init*.el
	if [ -d $(XDG_DIR_EMACS) ]; then ls -la $(XDG_DIR_EMACS)*; fi
	if [ -d $$HOME/.emacs.d ]; then ls -la $$HOME/.emacs*; fi

clean-local:
	@echo "CLEAN PREVIOUS INSTALL ..."
	@find $$HOME -maxdepth 3 -name init*.el
	@if [ -f $$HOME/$(LLL_FILE_USER_BACKUP) ]; then \
		mv -vf $$HOME/$(LLL_FILE_USER_BACKUP) $$HOME/.emacs; \
		if [ -f $$HOME/$(LLL_FILE_USER) ]; then \
			rm -vf $$HOME/$(LLL_FILE_USER); fi; fi
	@if [ -f $$HOME/.emacs.d/$(LLL_FILE_USER_BACKUP) ]; then \
		mv -vf $$HOME/.emacs.d/$(LLL_FILE_USER_BACKUP) $$HOME/.emacs.d/init.el; \
		if [ -f $$HOME/.emacs.d/$(LLL_FILE_USER) ]; then \
			rm -vf $$HOME/.emacs.d/$(LLL_FILE_USER); fi; fi
	@if [ -f $(XDG_DIR_EMACS)/$(LLL_FILE_USER_BACKUP) ]; then \
		mv -vf $(XDG_DIR_EMACS)/$(LLL_FILE_USER_BACKUP) $(XDG_DIR_EMACS)/init.el; \
		if [ -f $(XDG_DIR_EMACS)/$(LLL_FILE_USER) ]; then \
			rm -vf $(XDG_DIR_EMACS)/$(LLL_FILE_USER); fi; fi
	@if [ -d emacs ]; then \
		rm -Rvf emacs; fi
	@git clean -ix

# install-local: install-data-local install-exec-local

install-data-local: install-data-init
	@echo "INSTALL INIT FILES ..."
	@mkdir -vp $(XDG_DIR_EMACS)
	@cp -vf $(LLL_FILE_FIRST_RUN)	$(XDG_DIR_EMACS)
	@cp -vf $(LLL_FILE_PROFILE)	$(XDG_DIR_EMACS)
	@cp -vf $(LLL_FILE_PACKAGES)	$(XDG_DIR_EMACS)

# @cp -vf $(LLL_FILE_SOURCES)	$(XDG_DIR_EMACS)
# @cp -vf $(LLL_FILE_DEV)	$(XDG_DIR_EMACS)

install-exec-local:
	@echo "INSTALL EXEC LOCAL ..."
	@if [ ! -d emacs ]; then \
		git clone git://git.savannah.gnu.org/emacs.git; fi

# Other
installdirs-local:
	@echo "INSTALLDIRS LOCAL ..."

# Local phony targets
install-data-init:
	@echo "INSTALL DATA INIT ..."
	@if [ -f $$HOME/$(LLL_FILE_USER_BACKUP) ]; then \
		echo "EMaCS already installed. Do make clean-local."; exit 1; fi
	@if [ -f $$HOME/.emacs ]; then \
		mv -vf $$HOME/.emacs $$HOME/$(LLL_FILE_USER_BACKUP); \
		cp -vf $(LLL_FILE_INIT) $$HOME/.emacs; fi
	@if [ -f $$HOME/.emacs.el ]; then \
		mv -vf $$HOME/.emacs.el $$HOME/$(LLL_FILE_USER_BACKUP); \
		cp -vf $(LLL_FILE_INIT) $$HOME/.emacs.el; fi
	@if [ -f $$HOME/.emacs.d/init.el ]; then \
		mv -vf $$HOME/.emacs.d/init.el $$HOME/.emacs.d/$(LLL_FILE_USER_BACKUP); \
		cp -vf $(LLL_FILE_INIT) $$HOME/.emacs.d/init.el; fi
	@if [ -f $(XDG_DIR_EMACS)/init.el ]; then \
		mv -vf $(XDG_DIR_EMACS)/init.el $(XDG_DIR_EMACS)/$(LLL_FILE_USER_BACKUP); \
		cp -vf $(LLL_FILE_INIT) $(XDG_DIR_EMACS)/init.el; fi

install-data-debug: install-data-local
	@echo "INSTALL DATA DEBUG ..."
	@if [ -f $$HOME/.emacs ]; then \
		cp -vf $(LLL_FILE_DEBUG) $$HOME; fi
	@if [ -f $$HOME/.emacs.el ]; then \
		cp -vf $(LLL_FILE_DEBUG) $$HOME; fi
	@if [ -f $$HOME/.emacs.d/init.el ]; then \
		cp -vf $(LLL_FILE_DEBUG) $$HOME/.emacs.d; fi
	@if [ -f $(XDG_DIR_EMACS)/init.el ]; then \
		cp -vf $(LLL_FILE_DEBUG) $(XDG_DIR_EMACS); fi
