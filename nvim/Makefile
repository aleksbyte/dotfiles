.DEFAULT_GOAL := help
.PHONY: help
# Vars
SRC      :=$(PWD)
DST      :=$(HOME)
#DST      :=$(HOME)/cfgtest

XDG_CONFIG_HOME  :=$(DST)/.config
XDG_DATA_HOME    :=$(DST)/.local/share

nvim::  nvim  ##  nvim
neo::   neo  ##  neovim/lua

nvim::    ## nvim - cfg./plugins installations
	if [ ! -d ${XDG_CONFIG_HOME}/nvim ]; \
		then mkdir ${XDG_CONFIG_HOME}/nvim; fi;
	cp -r ${SRC}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim
	cp -r ${SRC}/nvim/coc-settings.json ${XDG_CONFIG_HOME}/nvim
	curl -fLo ${XDG_CONFIG_HOME}/nvim/autoload/plug.vim --create-dirs \
	   	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim -E -s -u ${XDG_CONFIG_HOME}/nvim/init.vim +PlugInstall +qall
	/usr/local/bin/pip3 install neovim
#	/usr/local/bin/pip3 install jedi
	nvim +PlugInstall +qall


header:
	@echo ""
	@echo "#######################"
	@echo " => Install nvim and nvim 0.5 (lua configs) "
	@echo "#######################"
	@echo ""

help: header   ##
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
#	| sort \
