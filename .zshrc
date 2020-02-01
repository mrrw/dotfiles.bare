# 
# YOU ARE HERE:  ~/.zshrc
# This config file is invoked when user opens zsh.

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/marrow/.zshrc'

# End of lines added by compinstall


#--------------------------------------------#
######  Customizations added by marrow  ######
#--------------------------------------------#

#---  "Eye Candy"
#
# Main Prompt:  Blue user, white @, blue host, yellow "~ $"
PROMPT='%U%F{blue}%n%u%F{white}@%F{blue}%M%F{yellow}%~ $ %F{reset}'
RPROMPT='%F{yellow}%D{%D [%L:%M}]'
#
# Transparency for X11.  See compton and transset-df for more details.
[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" >/dev/null

#---  "Basic auto/tab complete"
autoload -U compinit
zstyle ':completion:*' menu select	# Tab twice to enter menu mode.
zmodload zsh/complist
setopt COMPLETE_ALIASES
compinit
_comp_options+=(globdots) # Include hidden files.
#
# Additional completion customizations.

#---  "Autocomplete Ergonomics"
#
# vi mode
bindkey -v
export KEYTIMEOUT=1
#
# Autocomplete:  Tab Menu vim feels
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'q' send-break # exits menu-select without selecting
#


#---  "Vi Mode Enhancements"
#
# Change cursor shape for different vi modes.
function zle-keymap-select {
if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
echo -ne '\e[1 q'
elif [[ ${KEYMAP} == main ]] ||
     [[ ${KEYMAP} == viins ]] ||
     [[ ${KEYMAP} == '' ]] ||
     [[ $1 = 'beam' ]]; then
echo -ne '\e[5 q'
fi
}
zle -N zle-keymap-select
zle-line-init() {
zle -K viins # initiate 'vi insert' as keymap (can be removed if 'bindkey -V has been set elsewhere)
echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec () { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
#


# Uncomment the following line to enable command auto correction
ENABLE_CORRECTION="true"
#  Uncomment the following line to display red dots whilst wiating for completion.
COMPLETION_WAITING_DOTS="true"
#  Uncomment the following line to make completion case-insensitive
CASE_SENSITIVE="false" 
#
# Extended globbing.
# See https://www.techrepublic.com/article/globbing-wildcard-characters-with-zsh/
setopt EXTENDED_GLOB

#---  "Ranger Danger!"
#
# move in and out of ranger, which will act as a directory-chooser.
# Bound to ctrl-o
ra () {
     tmp="$(mktemp)"
     ranger --choosedir="$tmp" "$@"
     if [ -f "$tmp" ]; then
	  dir="$(cat "$tmp")"
	  rm -f "$tmp"
	  [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
     fi
}
bindkey -s '^o' 'ra\n'

# My sources.
source ~/.alias # Get my aliases.
eval "$(dircolors /etc/DIR_COLORS)"
zstyle ':copletion:*' list-colors ${(s.:.)LS_COLORS}
export COLOR_YELLOW='\e[0;35m'


#### 		PROMPT customizations.  
#### See:  http://nparikh.org/unix/prompt.php 
#
# Uncomment to make zsh look just like default bash prompt:
#PROMPT='[%n@%M %c]$ '


# Autostart tmux (broken)
#exec 'tmux new-session \; split-window -v -p 75 \; split-window -h -p 75 \; split-window -hb -p 66 \; attach \; select-pane'

####	       configure Powerline
#### See: https://www.archlinux.org/index.php/Powerline

#powerline-daemon -q
#. /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh

#-- cmatrix screensaver maybe?
cmatrix -abs -u5
source /usr/share/zsh/plugins/zsh
