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

# My mac shortcut
alias sshum='ssh chanyao@login.engin.umich.edu'
alias cp3='cd /Users/johnnychan/Desktop/im80/cplusplus/practices'
alias 281='cd /Users/johnnychan/Desktop/EECS281'

schw()
{
	WORD=$1
	echo "-----------------------------------------------------"
	echo "Searching for word '$WORD' in all C/C++ files..."
	echo "-----------------------------------------------------"
	grep --color=always -nrw $WORD --include=*.{cpp,c,h,hpp} ./
	echo "-----------------------------------------------------"
}

schp()
{
	PATTERN=$1
	echo "-----------------------------------------------------"
	echo "Searching for pattern '$PATTERN' in all C/C++ files..."
	echo "-----------------------------------------------------"
	grep --color=always -nr $PATTERN --include=*.{cpp,c,h,hpp} ./
	echo "-----------------------------------------------------"
}

replace()
{
	OLD=$1
	NEW=$2
	echo "-----------------------------------------------------"
	echo "Replacing '$OLD' with '$NEW' in all C/C++ files..."
	echo "-----------------------------------------------------"
	files=`find . -type f -name "*.cpp" -o -name "*.h" -o -name "*.c"`
	echo "Found and performing replacement in the following files:"
	for i in $files; do
		sed -i "s/$OLD/$NEW/g" "$i"
	done
	echo "$files"
	echo "-----------------------------------------------------"
}
