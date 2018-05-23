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

## List down all apps info
os-app-info:
	@cat $(_ROOT_DIR)/queries/apps/info.sql | osqueryi

## List process id and name opening most files
os-file-lsof:
	@cat $(_ROOT_DIR)/queries/files/lsof.sql | osqueryi

## List process detail for jps
os-jps:
	jps | awk '{print $$1}' | paste -sd "," - | xargs -IPIDS sed -e "s/\$${pid}/PIDS/" $(_ROOT_DIR)/queries/processes/process_detail.sql | osqueryi --json | jq  

## Show detail of a port. Argument PORT is required
os-port-detail:
ifeq ($(PORT),)
	@echo "Please supply argument $(_YELLOW)PORT$(_RESET)."
	@echo "e.g. $(_YELLOW)cmd os-port-detail PORT=12345$(_RESET)"
else
	@sed -e "s/\$${port}/$(PORT)/" $(_ROOT_DIR)/queries/ports/port_detail.sql | osqueryi --json | jq 
endif

## List process id and name using certain ports
os-port-ls:
	@cat $(_ROOT_DIR)/queries/ports/ports.sql | osqueryi

## List process id and name using certain ports with command lines
os-port-ls-cmdline:
	@cat $(_ROOT_DIR)/queries/ports/ports_cmdline.sql | osqueryi

## Show detail of a pid. Argument PID is required
os-process-detail:
ifeq ($(PID),)
	@echo "Please supply argument $(_YELLOW)PID$(_RESET)."
	@echo "e.g. $(_YELLOW)cmd os-process-detail PID=12345$(_RESET)"
else
	@sed -e "s/\$${pid}/$(PID)/" $(_ROOT_DIR)/queries/processes/process_detail.sql | osqueryi --json | jq 
endif

## Update the command to the latest
update:
	@cd $(_ROOT_DIR) && git pull origin master