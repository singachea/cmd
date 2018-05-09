_ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
_COLOR_GREEN    = \033[0;32m
_COLOR_RED = \033[0;31m
_COLOR_ORANGE  = \033[0;33m
_COLOR_NONE    = \033[m

default:
	@echo "Hello...there!\nYou can update your command by using $(_COLOR_GREEN)cmd update$(_COLOR_NONE)"

os-file-lsof:
	@cat $(_ROOT_DIR)/queries/files/lsof.sql | osqueryi

update:
	@cd $(_ROOT_DIR) && git pull origin master