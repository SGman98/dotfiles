all: update_upgrade install ohmyzsh node nvim nvim_others clean stow
update_upgrade:
	sudo apt-get update
	sudo apt-get upgrade

install:
	sudo apt-get install\
		stow\
		build-essential\
		cmake\
		curl\
		python3-dev\
		zsh\
		pandoc\
		git\
		bat\
		tree\
		neofetch\

ohmyzsh:
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	# install plugins
	git clone https://github.com/bobthecow/git-flow-completion $ZSH/custom/plugins/git-flow-completion
	git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH/custom/plugins/zsh-syntax-highlighting
	git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH/custom/plugins/zsh-vi-mode

node:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
	nvm install node

nvim:
	# install nvim 0.6
	curl -L https://github.com/neovim/neovim/releases/download/v0.6.0/nvim.appimage > nvim.appimage
	chmod +x nvim.appimage
	./nvim.appimage --appimage-extract
	mv squashfs-root / && ln -s /squashfs-root/AppRun /usr/bin/nvim
	npm install -g neovim
	rm nvim.appimage

nvim_others:
	# ripgrep
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
	sudo dpkg -i ripgrep_13.0.0_amd64.deb
	# fd-find
	sudo apt install fd-find

clean:
	# remove nvim if it's installed
	ifdef $(which nvim)
		rm $(which nvim)
	endif
	# if .zshrc exists, remove it
	ifdef $HOME/.zshrc
		rm $HOME/.zshrc
	endif
	# if .config/nvim not exists, create it so links will work
	ifndef $HOME/.config/nvim
		mkdir -p $HOME/.config/nvim
	endif
	# if .gitconfig exists, remove it
	ifdef $HOME/.gitconfig
		rm $HOME/.gitconfig
	endif

stow:
	stow -nv -t $HOME zsh git nvim


