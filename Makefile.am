# SUBDIRS = etc src
# non-POSIX variable name (probably a GNU make extension)
# TIMESTAMP = $(shell date -I)
# GITBRANCH = $(shell git name-rev --name-only HEAD)

# .ONESHELL:
# SHELL = /bin/bash
# .SHELLFLAGS = -c

GIT_BRANCH_MK = "master"

# TODO: Make help rule recursive
.PHONY: help

help:
	@echo 'Help message'
	@echo '  help		- This message.'
	@echo 'Targets:'
	@echo '  check		- Search for emacs init file.'
	@echo '  info		- Show user local emacs files.'
	@echo '  clean		- Undo previous installation.'
	@echo '  install	- (exec-local) Git clone GNU Emacs.'
	@echo '  		- (data-local) Rename .emacs or init.el files to -user.'

# RECURSIVE all check clean info install-exec install-data
all-local: help

check-local:
	GIT_BRANCH_SH=$$(git name-rev --name-only HEAD); \
	echo "Git Branch: $(GIT_BRANCH_MK) Branch_SH: $${GIT_BRANCH_SH}"; \
	git status -s

	@if [ -f $$HOME/.emacs ]; then \
		echo "($$HOME/.emacs) init file FOUND\
			will be renamed to ($$HOME/init-user.el)"; fi
	@if [ -f $$HOME/.emacs.el ]; then \
		echo "($$HOME/.emacs.el) init file FOUND\
			will be renamed to ($$HOME/init-user.el)"; fi
	@if [ -f $$HOME/.emacs.d/init.el ]; then \
		echo "($$HOME/.emacs.d/init.el) init file FOUND\
			will be renamed to ($$HOME/.emacs.d/init-user.el)"; fi
	@if [ -f $$HOME/.config/emacs/init.el ]; then \
		echo "($$HOME/.config/emacs/init.el) init file FOUND\
			will be renamed to ($$HOME/.config/emacs/init-user.el)"; fi
	@ls -la ./src/.emacs

info-local:
	@echo "INFO LOCAL FILES ..."
	if [ -d $$HOME/.config/emacs ]; then ls -la $$HOME/.config/emacs*; fi
	if [ -d $$HOME/.emacs.d ]; then ls -la $$HOME/.emacs*; fi

clean-local: info
	@echo "CLEAN PREVIOUS INSTALL ..."
	@if [ -f $$HOME/init-user.el ]; then \
		mv -vf $$HOME/init-user.el $$HOME/.emacs; fi
	@if [ -f $$HOME/.emacs.d/init-user.el ]; then \
		mv -vf $$HOME/.emacs.d/init-user.el $$HOME/.emacs.d/init.el; fi
	@if [ -f $$HOME/.config/emacs/init-user.el ]; then \
		mv -vf $$HOME/.config/emacs/init-user.el $$HOME/.config/emacs/init.el; fi
	@if [ -d emacs ]; then \
		rm -Rvf emacs; fi

# install: install-exec-local install-data-local
install-exec-local:
	@echo "INSTALL EXEC LOCAL ..."
	@if [ ! -d emacs ]; then \
		git clone git://git.savannah.gnu.org/emacs.git; fi

install-data-local:
	@echo "INSTALL DATA LOCAL ..."
	@if [ -f $$HOME/.emacs ]; then \
		mv -vf $$HOME/.emacs $$HOME/init-user.el; \
		cp -vf ./src/.emacs $$HOME; fi
	@if [ -f $$HOME/.emacs.el ]; then \
		mv -vf $$HOME/.emacs.el $$HOME/init-user.el; \
		cp -vf ./src/.emacs $$HOME/.emacs.el; fi
	@if [ -f $$HOME/.emacs.d/init.el ]; then \
		mv -vf $$HOME/.emacs.d/init.el $$HOME/.emacs.d/init-user.el; \
		cp -vf ./src/.emacs $$HOME/.emacs.d/init.el; fi
	@if [ -f $$HOME/.config/emacs/init.el ]; then \
		mv -vf $$HOME/.config/emacs/init.el $$HOME/.config/emacs/init-user.el; \
		cp -vf ./src/.emacs $$HOME/.config/emacs/init.el; fi

# Other
installdirs-local:
	@echo "INSTALLDIRS LOCAL ..."
