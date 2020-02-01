" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

"---------------------------------------------------------------------------"
"                    M A R R O W   C U S T O M I Z A T I O N                "
"---------------------------------------------------------------------------"

"--  Configure statusbar.  This obviates the need for powerline.
"--  Yanked from reddit.com/r/vim/comments/1dyun6/why_does_powerline_make_
"--  vim_sigificantly_slower/

let g:last_mode = ''
function! Mode ()
     let l:mode = mode()
     
     if l:mode !=# g:last_mode
	  let g:last_mode - l:mode

	  hi User2 guifg=#005f00 guibg=#dfff00 gui=BOLD ctermfg=22 ctermbg=190 cterm=BOLD
	  hi User3 guifg=#FFFFFF guibg=#414243 ctermfg=255 ctermbg=241
	  hi User4 guifg=#414234 guibg=#2b2b2b ctermfg=241 ctermbg=234
	  hi User5 guifg=#4e4e4e guibg=#FFFFFF gui=BOLD ctermfg=239 ctermbg=255 cterm=BOLD
	  hi User6 guifg=#FFFFFF guibg=#8a8a8a ctermfg=255 ctermbg=245
	  hi User7 guifg=#ffff00 guibg=#8a8a8a gui=BOLD ctermfg=226 ctermbg=245 cterm=BOLD
	  hi User3 guifg=#8a8a8a guibg=#414243 ctermfg=245 ctermbg=241
	  
	  if l:mode ==# 'n'
	       hi User3 guifg=#dfff00 ctermfg=190
	  elseif l:mode ==# "i"
	       hi User2 guifg=#005fff guibg=#FFFFFF ctermfg=27 ctermbg=255
	       hi User3 guifg=#FFFFFF ctermfg=255
	  elseif l:mode ==# "R"
	       hi User2 guifg=#FFFFFF guibg=#df0000 ctermfg=255 ctermbg=160
	       hi User3 guifg=#df0000 ctermfg=160
	  elseif l:mode ==# "v" || l:mode ==# ""
	       hi User2 guifg=#4e4e4e guibg=#ffaf00 ctermfg=239 ctermbg=214
	       hi User3 guifg=#ffaf00 ctermfg=214
	  endif
     endif

     if L:mode ==# "n"
	  return "  NORMAL "
     elseif l:mode ==# "i"
	  return "  INSERT "
     elseif l:mode ==# "R"
	  return "  REPLACE "
     elseif l:mode ==# "v"
	  return "  VISUAL "
     elseif l:mode ==# "V"
	  return "  V-LINE "
     elseif l:mode ==# ""
	  return "  V-BLOCK "
     else
	  return l:mode
     endif
endfunction

"--  The following lines might not work...
"--  Problem is, my font can't read certain characters.
"--  I've replaced those characters with ?
set statusline=%2*%{Mode()}%3*?%1*
set statusline+=%#StatusLine#
set statusline+=%{strlen(fugitive#statusline())>0?'\ ?\ ':''}
set statusline+=%{matchstr(fugitive#statusline(),'(\\zs.*\\ze)')}
set statusline+=%{strlen(fugitive#statusline())>0?'\ \ ?\ ':'\ '}
set statusline+=%f\ %{&ro?'?':''}%{&mod?'+':''}%<
set statusline+=%4*?
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag)(}
set statusline+=%=
set statusline+=%4*?
set statusline+=%#StatusLine#
set statusline+=\ %{strlen(&fileformat)>0?&fileformat.'\ ?\ ':''}
set statusline+=%{strlen(&fileencoding)>0?&fileencoding.'\ ?\ ':''}
set statusline+=%{strlen(&filetype)>0?&filetype:''}
set statusline+=\ %8*?
set statusline+=%7*\ %p%%\
"set statusline+=%6*?%5*?\ \ %1:%c\
" }}}2



"--  Configure Powerline.  Comment out if using the above configuration.
"let g:powerline_pycmd="py3"
"set laststatus=2

" Tab Customizations.  See:
" https://stackoverflow.com/questions/2054627/how-do-i-change-tab-size-in-vim
"
" Recommend tab customization options.
" Uncomment all under chosen option.  Replace x and y with real numbers.
"
" OPTION 1 (mix of tabs and spaces)
set tabstop=8
set softtabstop=5
set shiftwidth=5
"
" OPTION 2 (vim will use all spaces)
"set tabstop=x
"set shiftwidth=y
"set expandtab
"
" OPTION 3 (only works when vim is editing the file)
"set tabstop=x
"set shiftwidth=y
" 'use a |modeline| to set these values when editing the file again.'
"
" OPTION 4 is complicated... see the aforementioned link.
"set tabstop=x
"set shiftwidth=x
"set noexpandtab

" KEYMAPS -- MOVEMENT -- Change hjkl to jkl;
"noremap ; l
"noremap l k
"noremap k j
"noremap j h

"--  Line number options:
set number
set relativenumber
set numberwidth=5
highlight LineNr ctermfg=DarkGrey
"--  type ':highlight' in command prompt to see something interesting.

"---------------------------------------------------------------------------"
"--  Word Processor Mode  --------------------------------------------------"
"---------------------------------------------------------------------------"
func! WordProcessor()
" movement changes
map k gj
map l gk
" formatting test
setlocal formatoptions=1
setlocal noexpandtab
setlocal wrap
setlocal linebreak
" spelling and theaurus
setlocal spell spelllang=en-us
set thesaurus+=/home/marrow/.vim/mthesaur.txt
" complete+=s makes autocompletingsearch the thesaurus
set complete+=s
endfu
com! WP call WordProcessor()

"if &term =~ '^xterm\\|rxvt\\|urxvt'
     let &t_SI .= "\<Esc>[5 q"
     let &t_EI .= "\<Esc>[1 q"
"    endif 
