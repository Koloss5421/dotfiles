##
#
# Koloss5421 .bashrc
#
##

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

## Color Promp setup if starship fails.
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi


# enable programmable completion features (you don't need to enable
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


## Bashrc Custom:
reset_smartcard () {
    echo "[+] Resetting Ssh-Agent..."
    ssh-add -D
    echo "[+] Adding pkcs to agent..."
    success="$(ssh-add -s /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so 2>&1)"
    error=$(echo "$success" | grep "Could not add card")
    if [[ ! -z "$error" ]]; then
        echo "[!] Killing ssh-agent..."
        export SSH_AGENT_PID=$(pidof ssh-agent)
        eval `ssh-agent -k`
        echo "[+] Starting SSH Agent..."
        eval `ssh-agent -s`
        echo "[+] Adding pkcs to agent..."
        ssh-add -s /usr/lib/x86_64-linux-gnu/opensc-pkcs11.so
    fi
}

## Paths
export PATH=$PATH:/home/koloss/.local/bin
export GOPATH=/opt/programs/go
#. "$HOME/.cargo/env"

## Alias
alias rsc=reset_smartcard
alias vim=nvim

## Bind/Set
#bind 'set show-all-if-ambiguous on'
#bind 'TAB:menu-complete'
#bind '"\e[Z":menu-complete-backward'
## Exec Starship
eval "$(starship init bash)"
