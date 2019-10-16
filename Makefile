# platform
HAVE_BREW:=$(shell which brew)
HAVE_FISH:=$(shell which fish)
HAVE_PECO:=$(shell which peco)

# application
HAVE_NVIM:=$(shell which nvim)
HAVE_TMUX:=$(shell which tmux)
HAVE_ALACRITTY:=$(shell which alacritty)

XDG_CONFIG_HOME:=$(HOME)/.config
CONFIG_PATH:=./configs

## fishinstall
.PHONY: setup-fish setup-tmux setup-vim setup-alacritty
setup-fish: brew
ifndef HAVE_FISH
	@echo "install fish"
	@brew install fish
endif
	@echo "setup fish"
	@cp -r $(CONFIG_PATH)/fish $(XDG_CONFIG_HOME)

setup-tmux: brew
ifndef HAVE_TMUX
	@echo "install tmux"
	@brew install tmux
	# wifiとbattery表示をインストール
	@curl "https://raw.githubusercontent.com/b4b4r07/dotfiles/master/.tmux/bin/battery" > /usr/local/bin/tmux-battery
	@curl "https://raw.githubusercontent.com/b4b4r07/dotfiles/master/.tmux/bin/wifi" > /usr/local/bin/tmux-wifi
endif
	@echo "setup tmux"
	@cp -r $(CONFIG_PATH)/tmux $(XDG_CONFIG_HOME)
	@chmod 755 /usr/local/bin/tmux-*

# vim本体は.vimrcを配備するだけ
setup-vim: brew
	@echo "setup vim"
	@cp $(CONFIG_PATH)/vim/vimrc $(HOME)/.vimrc
ifndef HAVE_NVIM
	@echo "install nvim"
	@brew install nvim
endif
	@echo "setup nvim"
	@cp -r $(CONFIG_PATH)/vim/nvim $(XDG_CONFIG_HOME)

setup-alacritty: brew
ifndef HAVE_ALACRITTY
	@echo "install alacritty"
	@brew cask install alacritty
	@ln /System/Volumes/Data/Applications/Alacritty.app/Contents/MacOS/alacritty /usr/local/bin/alacritty
endif
	@echo "setup alacritty"
	@cp -r $(CONFIG_PATH)/alacritty $(XDG_CONFIG_HOME)

setup:brew peco
	@echo "setup"
	@make "setup-$(shell ls configs | peco)"

setup-all:brew peco
	@make setup-alacritty
	@make setup-fish
	@make setup-tmux
	@make setup-vim

## Install package
.PHONY: brew peco
brew:
ifndef HAVE_BREW
	@echo "Installing HomwBrew"
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
endif

peco: brew
ifndef HAVE_PECO
	@echo "Installing peco"
	@brew install peco
endif
