# .zshrc Setting "zsh"  

#for i in /etc/profile.d/*.sh ; do
#    if [ -r $i ]; then
#	. $i
#    fi
#done
#for i in /usr/osxws/etc/profile.d/*.sh ; do
#    if [ -r $i ]; then
#	. $i
#    fi
#done

unset i

# Initialize & default setting complete system
autoload -U compinit
compinit

# Show current path in the title bar
chpwd() {
    [[ -t 1 ]] || return
    case $TERM in
     sun-cmd) print -Pn "\e]l%~\e\\"
       ;;
     *xterm*|rxvt|(ml|dt|k|E)term) print -Pn "\e]2;%~\a"
       ;;
   esac
}

# Set Special Zsh option
setopt auto_pushd	# For 'gd' to memory corrent direcotry
setopt auto_cd		# Change directory without 'cd'
setopt no_hup		# Not to kill any back ground jobs after logout
setopt extended_glob	# Using extended Glob
setopt hist_ignore_dups	# Ignoring same commands in history
#setopt share_history	# History sharing any terminals

# Set Special Zsh complete features
compctl -c jman man	# "man" arg are completed from all commands
compctl -/g '*.dat' xgraph	# Set candidate for the command to "--.dat"
compctl -/g '*.yap' yaplot      # Set candidate of the command to "--.yap"
unsetopt PROMPT_CR      # Don't overwrite last output without LF by prompt

# User specific aliases and functions
alias	gd='dirs -v; echo -n "select number: "; read newdir; cd -"$newdir"'
alias	-g L='| less' 
alias	-g G='| grep'
alias	-g X='| xgraph'

# set aliases
alias   ls='ls -FGv'
alias   ll='\ls -lhaGv'
alias   la='\ls -aGv'
#alias   rm='rm -i'
alias   'rm *'='rm * -i'
alias   cp='cp -i'
alias   eng='export LANG=C LANGUAGE=C LC_ALL=C'	# May be not neccesary

if [ -f "/usr/osxws/etc/man.conf" ]; then
    alias man="man -C /usr/osxws/etc/man.conf"
fi

if [ -x /usr/osxws/bin/openemacs ]; then
	alias	emacs='openemacs'
fi

# To use Xhost
#if [ $SSH_CLIENT ]
#then
#        export DISPLAY=$SSH_CLIENT:0.0
#else
#        alias   sshX="export ORIGDISPLAY=$DISPLAY;export DISPLAY=:0;xhost +;\ssh -X"
#fi

# for un-expected home directories
if [ "$TERM" = "xterm" ] || [ "$TERM" = "kterm" ]
then
	if ! [ $KADOBEYAHOME ]
	then
		export KADOBEYAHOME=1
		cd
	fi
fi

# check dot files
if [ -x /usr/osxws/bin/osxws-upgrade ]
then
        /usr/osxws/bin/osxws-upgrade
fi

# Get the user's rc file
if [ -f ~/.zshmyrc ]; then
	source ~/.zshmyrc
fi

PS1='%Bプロンプト%b%~ $ '
#PS1='%Bprompt%b%~ $ '

alias E='emacsclient -c'
alias kill-emacs="emacsclient -e '(kill-emacs)'"

## 色を使う
setopt prompt_subst

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# cd したら ls もする
cdls ()
{
    \cd "$@" && ls
}
#alias cd="cdls"

alias myssh="ssh -X kamibayashi@mgccs.s.kanazawa-u.ac.jp"
eval "$(pyenv init -)"

export PYENV_ROOT="HOME/.pyenv"exportPATH="HOME/.pyenv"exportPATH="{PYENV_ROOT}/bin:PATH"eval"PATH"eval"(pyenv init -)"
