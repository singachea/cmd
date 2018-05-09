_ROOT_DIR=~/.cmd/repo

default:
	@echo "Hello... you can update your command by using \"cmd update\""

update:
	cd $(_ROOT_DIR) && git pull origin master