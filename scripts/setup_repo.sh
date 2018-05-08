mkdir -p ~/.cmd && cd ~/.cmd

function initialize_repo() {
    if  [ -d ~/.cmd/repo ]; then
        cd repo && git pull origin master
    else
        git clone git@github.com:singachea/cmd.git repo
    fi
}

function add_alias() {
    if [ ! -f ~/.zshrc ]; then
        echo "There is no file '~/.zshrc'. You should install zsh first."
    else
        echo "alias cmd=\"make -f ~/.cmd/repo/Makefile\"" >> ~/.zshrc
        # sed -i -- 's/alias cmd=.*/alias cmd=hello/g'
    fi

    source ~/.zshrc
}

initialize_repo
add_alias

