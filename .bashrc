#
# YOU ARE HERE:  ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# transparency (see compton and transset-df for more details)
[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" >/dev/null

# autostart tmux upon login
if [ -z "$TMUX" ]; then
     mux default
fi

source ~/.alias # Get my aliases.'
