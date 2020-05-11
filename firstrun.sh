# Run this script the first time you set-up your system
# TODO: would be more elegant to run separate scripts for each OS and just use this script to choose


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # install packages on linux
	add-apt-repository ppa:martin-frost/thoughtbot-rcm
	add-apt-repository ppa:keithw/mosh
	apt-get update
	apt-get install mosh rcm neovim fzf ripgrep
	# symlinks for windows
	# OneDrive
	ln -s /mnt/c/Users/steve/Onedrive $HOME
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# place curl for brew then brew install here
	brew update && brew upgrade && brew install rcm fzf ripgrep
        # Mac OSX
	# symlinks
	# OneDrive already mounted at home
else
        # Unknown.
	echo "!! ${OSTYPE} unknown"
fi

# echo "-- Symlinking this directory to ~/.dotfiles (to use rcm)"
ln -s $PWD $HOME/.dotfiles

