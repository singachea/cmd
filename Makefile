_ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

# COLORS
_GREEN  := $(shell tput -Txterm setaf 2)
_YELLOW := $(shell tput -Txterm setaf 3)
_WHITE  := $(shell tput -Txterm setaf 7)
_RESET  := $(shell tput -Txterm sgr0)


_TARGET_MAX_CHAR_NUM=20
## Show help
help:
	@echo 'Hello...there!'
	@echo 'You can update your command by using $(_GREEN)cmd update$(_RESET)'
	@echo ''
	@echo 'Usage:'
	@echo '  ${_YELLOW}cmd${_RESET} ${_GREEN}<target>${_RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${_YELLOW}%-$(_TARGET_MAX_CHAR_NUM)s${_RESET} ${_GREEN}%s${_RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## List process id and name opening most files
os-file-lsof:
	@cat $(_ROOT_DIR)/queries/files/lsof.sql | osqueryi

## Update the command to the latest
update:
	@cd $(_ROOT_DIR) && git pull origin master