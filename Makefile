# SUBDIRS = etc src
# non-POSIX variable name (probably a GNU make extension)
# TIMESTAMP = $(shell date -I)
# GITBRANCH = $(shell git name-rev --name-only HEAD)

# .ONESHELL:
# SHELL = /bin/bash
# .SHELLFLAGS = -c

GIT_BRANCH_MK = "master"

LLL_USER_FILE		= "init-user.el"
LLL_USER_BACKUP_FILE	= "init-user-backup.el"
LLL_FIRST_RUN_FILE	= "init-first-run.el"
LLL_PACKAGES_FILE	= "init-packages.el"
LLL_SOURCES_FILE	= "init-sources.el"
LLL_KEY_BINDINGS_FILE	= "init-key-bindings.el"
LLL_DEV_PROJECTS_FILE	= "init-dev-projects.el"

# TODO: Make help rule recursive
.PHONY: help install-vanilla install-full

help:
	@echo 'Help message'
	@echo '  help		- This message.'
	@echo 'Targets:'
	@echo '  check-local		- Search for emacs init file.'
	@echo '  info-local		- Show user local emacs files.'
	@echo '  clean-local		- Undo previous installation.'
	@echo '  install-local		- (data) Copy and Rename .emacs or init.el.'
	@echo '  			- (exec) Git clone GNU Emacs.'
	@echo '  install-vanilla	- Use first run customizations.'
	@echo '  install-full		- Use ALL customizations.'

# RECURSIVE all check clean info install-exec install-data
all-local: help

check-local:
	GIT_BRANCH_SH=$$(git name-rev --name-only HEAD); \
	echo "Git Branch: $(GIT_BRANCH_MK) Branch_SH: $${GIT_BRANCH_SH}"; \
	git status -s

	@if [ -f $$HOME/.emacs ]; then \
		echo "($$HOME/.emacs) init file FOUND\
			will be renamed to ($$HOME/$(LLL_USER_BACKUP_FILE))"; fi
	@if [ -f $$HOME/.emacs.el ]; then \
		echo "($$HOME/.emacs.el) init file FOUND\
			will be renamed to ($$HOME/$(LLL_USER_BACKUP_FILE))"; fi
	@if [ -f $$HOME/.emacs.d/init.el ]; then \
		echo "($$HOME/.emacs.d/init.el) init file FOUND\
			will be renamed to ($$HOME/.emacs.d/$(LLL_USER_BACKUP_FILE))"; fi
	@if [ -f $$HOME/.config/emacs/init.el ]; then \
		echo "($$HOME/.config/emacs/init.el) init file FOUND\
			will be renamed to ($$HOME/.config/emacs/$(LLL_USER_BACKUP_FILE))"; fi
	@ls -la ./src/.emacs

info-local:
	@echo "INFO LOCAL FILES ..."
	if [ -d $$HOME/.config/emacs ]; then ls -la $$HOME/.config/emacs*; fi
	if [ -d $$HOME/.emacs.d ]; then ls -la $$HOME/.emacs*; find $$HOME -maxdepth 3 -name init*.el; fi

clean-local: info-local
	@echo "CLEAN PREVIOUS INSTALL ..."
	@if [ -f $$HOME/$(LLL_USER_BACKUP_FILE) ]; then \
		mv -vf $$HOME/$(LLL_USER_BACKUP_FILE) $$HOME/.emacs; \
		if [ -f $$HOME/$(LLL_USER_FILE) ]; then \
			rm -vf $$HOME/$(LLL_USER_FILE); fi; fi
	@if [ -f $$HOME/.emacs.d/$(LLL_USER_BACKUP_FILE) ]; then \
		mv -vf $$HOME/.emacs.d/$(LLL_USER_BACKUP_FILE) $$HOME/.emacs.d/init.el; \
		if [ -f $$HOME/.emacs.d/$(LLL_USER_FILE) ]; then \
			rm -vf $$HOME/.emacs.d/$(LLL_USER_FILE); fi; fi
	@if [ -f $$HOME/.config/emacs/$(LLL_USER_BACKUP_FILE) ]; then \
		mv -vf $$HOME/.config/emacs/$(LLL_USER_BACKUP_FILE) $$HOME/.config/emacs/init.el; \
		if [ -f $$HOME/.config/emacs/$(LLL_USER_FILE) ]; then \
			rm -vf $$HOME/.config/emacs/$(LLL_USER_FILE); fi; fi
	@if [ -d emacs ]; then \
		rm -Rvf emacs; fi
	@git clean -ix

# install: install-data-local install-exec-local

install-data-local:
	@echo "INSTALL DATA LOCAL ..."
	@if [ -f $$HOME/.emacs ]; then \
		mv -vf $$HOME/.emacs $$HOME/$(LLL_USER_BACKUP_FILE); \
		cp -vf ./src/.emacs $$HOME; fi
	@if [ -f $$HOME/.emacs.el ]; then \
		mv -vf $$HOME/.emacs.el $$HOME/$(LLL_USER_BACKUP_FILE); \
		cp -vf ./src/.emacs $$HOME/.emacs.el; fi
	@if [ -f $$HOME/.emacs.d/init.el ]; then \
		mv -vf $$HOME/.emacs.d/init.el $$HOME/.emacs.d/$(LLL_USER_BACKUP_FILE); \
		cp -vf ./src/.emacs $$HOME/.emacs.d/init.el; fi
	@if [ -f $$HOME/.config/emacs/init.el ]; then \
		mv -vf $$HOME/.config/emacs/init.el $$HOME/.config/emacs/$(LLL_USER_BACKUP_FILE); \
		cp -vf ./src/.emacs $$HOME/.config/emacs/init.el; fi

install-exec-local:
	@echo "INSTALL EXEC LOCAL ..."
	@if [ ! -d emacs ]; then \
		git clone git://git.savannah.gnu.org/emacs.git; fi

install-vanilla: install-data-local
	@echo "INSTALL VANILLA ..."
	@mkdir -vp $$HOME/.config/emacs
	@cp -vf ./src/$(LLL_FIRST_RUN_FILE) $$HOME/.config/emacs

install-full: install-vanilla
	@echo "INSTALL FULL ..."
	@cp -vf ./src/$(LLL_PACKAGES_FILE) $$HOME/.config/emacs
	@cp -vf ./src/$(LLL_SOURCES_FILE) $$HOME/.config/emacs
	@cp -vf ./src/$(LLL_KEY_BINDINGS_FILE) $$HOME/.config/emacs
	@cp -vf ./src/$(LLL_DEV_PROJECTS_FILE) $$HOME/.config/emacs

# Other
installdirs-local:
	@echo "INSTALLDIRS LOCAL ..."
