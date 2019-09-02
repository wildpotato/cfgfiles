# .bashrc

# User specific aliases and functions
#. .alias
alias ducks='du -cks * | sort -rn | head -15'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

PATH=$PATH:/home/username/bin:/usr/local/homebrew
export PATH

# Set alias for dotfiles
alias dotfiles='/usr/bin/git --git-dir=/Users/johnnychan/.dotfiles/ --work-tree=/Users/johnnychan'

# See https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=/Users/johnnychan/.cfg/ --work-tree=/Users/johnnychan'

# Some command line shortcuts
alias ll='ls -al'
alias sshum='ssh chanyao@login.engin.umich.edu'
