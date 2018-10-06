
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2016 Mar 25
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" ============================== Basic ========================================
syntax on " high light key words

set nocp  " set no vi compatible mode
set number
set ruler " show the cursor position all the time
" set hls   " high light search result
 set nohls   " high light search result
set is    " set incsearch ,incremental search(display search result when typing)
set ic    " set ignorecase, ignore case in search patterns
set scs   " set smartcase, override the 'ic' option if search pattern contains upper case characters.
set backspace=indent,eol,start " allow backspacing over everything in insert mode, include indent/endOfLine/InsertStart
set whichwrap=b,s,<,>,[,] " see help whichwrap

set encoding=utf-8
" set langmenu=zh_CN.UTF-8
" language message zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1,default

if v:lang =~?'^\(zh\)\|\(ja\)\|\(ko\)'
    set ambiwidth=double " see help
endif

" ============================== Text Edit ====================================
set autoindent " always set autoindenting on
set smartindent 
filetype plugin indent on

set sw=4 " set shift width(auto indent)
set ts=4 " set Tab width
set et   " set expandtab, use the appropriate number of spaces to insert a Tab.
set smarttab " a Backspace will delete a 'shiftwidth' worth of space at Start Of Line

" set spell " spell check, press 'z=' to display spell advice, press ']s'jump to next spell warning
autocmd filetype text,c,c++,python set nospell " spell check, press 'z=' to display spell advice, press ']s'jump to next spell warning

" ============================== Line Break ===================================
" set tw=78 " textwidth, set line break when cursor exceed 78 column
set lbr " do not allow line break at middle of a word
if v:lang =~?'^\(zh\)\|\(ja\)\|\(ko\)'
    set fo+=mB " help formatoptions
endif

" ============================== Folding ======================================
autocmd filetype c,c++ set foldenable
autocmd filetype c,c++ set foldmethod=syntax
autocmd filetype c,c++ set foldcolumn=0
autocmd filetype c,c++ setlocal foldlevel=1
" autocmd filetype c,c++ set foldclose=all
autocmd filetype c,c++ nnoremap <spacd> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " use blankspace to fold/unfold
" zf to create an fold
" zo to open an fold

" ============================== C/C++ Coding =================================
set sm " show match pairs
set matchtime=4 " tenths of a second to show the match paren when showmatch is set
autocmd filetype c,c++ set cindent
autocmd filetype c,c++ set cino=:0g0t0(sus " see help cinoptions-values

" ============================== Python Coding =================================
autocmd filetype python set tabstop=4 shiftwidth=4 expandtab

" ============================== Other ========================================
set selection=inclusive
set wildmenu " show auto completion words above the command line
" set colorscheme default " select color scheme

set noswapfile
set nobackup
set cursorline " high light cursor line
" set cursorcolumn
set clipboard+=unnamed " shared clipboard

" set autochdir " set file directory as current work directory


" ============================== Graph ========================================
if (has("gui_running"))
"    set nowrkp
else

endif

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit
