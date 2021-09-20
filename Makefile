.DEFAULT_GOAL := help
.PHONY: help
# Vars
SRC      :=$(PWD)
DST      :=$(HOME)
#DST      :=$(HOME)/cfgtest

XDG_CONFIG_HOME  :=$(DST)/.config
XDG_DATA_HOME    :=$(DST)/.local/share

basic:: zsh  nvim  ## zsh + nvim 
work:: basic  vim tmux sshrc  ## zsh + nvim + vim + tmux + sshrc  

zsh::  ## zsh cfg installation
	if [ ! -d ${XDG_CONFIG_HOME}/zsh ]; \
	   	then mkdir -p ${XDG_CONFIG_HOME}/zsh; fi;
	cp ${SRC}/zsh/zshenv $(XDG_CONFIG_HOME)/zsh/.zshenv
	cp ${SRC}/zsh/zshrc $(XDG_CONFIG_HOME)/zsh/.zshrc
	cp ${SRC}/zsh/alias $(XDG_CONFIG_HOME)/zsh/
	if [ ! -f ${DST}/.localrc ]; \
	    then cp -f $(SRC)/localrc.example $(DST)/.localrc; \
	fi;
	ln -svf $(XDG_CONFIG_HOME)/zsh/.zshenv $(DST)/.zshenv
	ln -svf $(XDG_CONFIG_HOME)/zsh/.zshrc $(DST)/.zshrc

nvim::    ## neovim-cfg./plugins installations
	if [ ! -d ${XDG_CONFIG_HOME}/nvim ]; \
		then mkdir ${XDG_CONFIG_HOME}/nvim; fi;
	cp -r ${SRC}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim
	cp -r ${SRC}/nvim/coc-settings.json ${XDG_CONFIG_HOME}/nvim
	curl -fLo ${XDG_CONFIG_HOME}/nvim/autoload/plug.vim --create-dirs \
	   	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim -E -s -u ${XDG_CONFIG_HOME}/nvim/init.vim +PlugInstall +qall
	/usr/local/bin/pip3 install neovim
	/usr/local/bin/pip3 install jedi
	nvim +PlugInstall +qall

vim::    ## vim-cfg installations
	test ! -d ${XDG_CONFIG_HOME}/vim && mkdir -p ${XDG_CONFIG_HOME}/vim
	cp -r ${SRC}/vim/* ${XDG_CONFIG_HOME}/vim
	rm -Rf ~/.vimrc
	ln -svf ${XDG_CONFIG_HOME}/vim/vimrc ~/.vimrc

tmux::    ## tmux installations
	if [ ! -d ${XDG_CONFIG_HOME}/tmux ]; \
		then mkdir -p ${XDG_CONFIG_HOME}/tmux; fi;
	cp -r ${SRC}/tmux/tmux.conf ${XDG_CONFIG_HOME}/tmux
	rm -Rf ~/.tmux.conf
	ln -svf ${XDG_CONFIG_HOME}/tmux/tmux.conf ~/.tmux.conf

sshrc::    ## sshrc installations
	if [ ! -d ${XDG_CONFIG_HOME}/sshrc ]; \
		then mkdir -p ${XDG_CONFIG_HOME}/sshrc; fi;
	cp -r ${SRC}/sshrc/sshrc ${XDG_CONFIG_HOME}/sshrc
	mkdir -p ${XDG_CONFIG_HOME}/sshrc/sshrc.d
	ln -svf ${XDG_CONFIG_HOME}/vim/vimrc ${XDG_CONFIG_HOME}/sshrc/sshrc.d/.vimrc

header:
	@echo ""
	@echo "#######################"
	@echo " => ${XDG_CONFIG_HOME} "
	@echo "#######################"
	@echo ""

help: header   ##
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
#	| sort \

