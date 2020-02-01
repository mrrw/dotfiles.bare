# copied from /etc/zsh/zprofile for the purposes of running xorg upon login when using zsh as my default shell.
# ly will call this file instead of ~.xinitrc
# ~/.zprofile

emulate sh -c 'source /etc/profile'

#if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#     exec startx
#fi

xcape -e 'Control_L=Escape;Caps_Lock=Escape'
