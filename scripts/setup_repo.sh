INSTALL_FOLDER=~/.cmd
mkdir -p $INSTALL_FOLDER && cd $INSTALL_FOLDER 

function initialize_repo() {
    if  [ -d $INSTALL_FOLDER/repo ]; then
        cd repo && git pull origin master
    else
        git clone git@github.com:singachea/cmd.git repo
    fi
}

function add_alias() {
    if [ ! -f ~/.zshrc ]; then
        echo "There is no file '~/.zshrc'. You should install zsh first."
    else
        sed -i '' '/alias cmd=.*/d' ~/.zshrc
        echo "alias cmd=\"make -f ~/.cmd/repo/Makefile\"" >> ~/.zshrc
    fi
}

function install_brewfile() {
    brew bundle --file=$INSTALL_FOLDER/repo/Brewfile
}

initialize_repo && install_brewfile && add_alias

