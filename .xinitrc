#!/bin/sh
# written in C

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#-------------------------------------------------#  
#--  customization @marrow  ----------------------#
#-------------------------------------------------#  

#--  start some more nice programs

## start i3 and urxvt daemon
#urxvtd -q -f -o
#exec i3

#--  start xmonad and other programs
#--  this will take experimentation.

#--  The following will actually start xcape
#--  before starting xmonad!  But why?
#sleep 10; xterm; xterm; xcape &
#exec xmonad

#--  Yet, this doesn't start xcape.  But why not? 
#xcape &
#exec xmonad

#--  This breaks X and shuts the server down.
#--  "unexpected token ;"  I think I just can't 
#--  put both & and ; sequentially.
#xterm &; xcape &
#exec xmonad

#--  This starts all programs, but requires
#--  user intervention (user must exit xterm): 
#xterm; xcape &
#exec xmonad

#--  This does not start xcape:
#xcape; exec xmonad

#--  This breaks X ("unexpected token ;") :
#xterm; xcape &; exec xmonad

#--  This starts xterm and xmonad,
#--  but somehow does not start xcape:
#xterm & xcape & sleep 0.5
#exec xmonad

#--  Also startx xterm and xmonad,
#--  but somehow does not start xcape:
#xterm & xcape; sleep 1
#exec xmonad

#--  I'll bet you can't put anything after xcape,
#--  not even sleep.
#--  Yet not even this opens xcape:
#--  Note:  I just looked, and xcape is shown in htop.
#xterm & sleep 1 & xcape &
#exec xmonad

#--  This doesn't allow xmonad to run:
#exec xmonad & xcape & sleep 3

#--  Runs xcape, but xcape doesn't work (the most common problem):
#(sleep 5s && xcape) &
#exec xmonad

#--  Finally, this worked!!
#--  I had to define 'Caps_Lock=Escape' to make xcape work from xinitrc:
#/home/marrow/start_jack.sh

xcape -e 'Control_L=Escape;Caps_Lock=Escape' &
exec xmonad
