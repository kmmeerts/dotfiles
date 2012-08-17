scriptencoding utf-8

" Remove all autocommands
autocmd!


if v:lang =~? "^ko"
  set fileencodings=euc-kr
  set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~? "^ja_JP"
  set fileencodings=euc-jp
  set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~? "^zh_TW"
  set fileencodings=big5
  set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~? "^zh_CN"
  set fileencodings=gb2312
  set guifontset=*-r-*
endif

" If we have a BOM, always honour that rather than trying to guess.
if &fileencodings !~? "ucs-bom"
  set fileencodings^=ucs-bom
endif

if &fileencodings !~? "utf-8"
  set fileencodings+=utf-8
endif

" Sane fallback
set fileencodings+=default

" {{{ Syntax highlighting settings
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Terminal fixes
if &term ==? "xterm"
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
  set ttymouse=xterm2
endif

if &term ==? "gnome" && has("eval")
  " Set useful keys that vim doesn't discover via termcap but are in the
  " builtin xterm termcap. See bug #122562. We use exec to avoid having to
  " include raw escapes in the file.
  exec "set <C-Left>=\eO5D"
  exec "set <C-Right>=\eO5C"
endif


if isdirectory(expand("$VIMRUNTIME/ftplugin"))
  filetype plugin on
endif

if has("eval")
  let is_bash=1
endif

if has("autocmd")

augroup gentoo
  au!

  " Gentoo-specific settings for ebuilds.  These are the federally-mandated
  " required tab settings.  See the following for more information:
  " http://www.gentoo.org/proj/en/devrel/handbook/handbook.xml
  " Note that the rules below are very minimal and don't cover everything.
  " Better to emerge app-vim/gentoo-syntax, which provides full syntax,
  " filetype and indent settings for all things Gentoo.
  au BufRead,BufNewFile *.e{build,class} let is_bash=1|setfiletype sh
  au BufRead,BufNewFile *.e{build,class} set ts=4 sw=4 noexpandtab

  " In text files, limit the width of text to 78 characters, but be careful
  " that we don't override the user's setting.
  autocmd BufNewFile,BufRead *.txt
        \ if &tw == 0 && ! exists("g:leave_my_textwidth_alone") |
        \     setlocal textwidth=78 |
        \ endif

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
        \ if ! exists("g:leave_my_cursor_position_alone") |
        \     if line("'\"") > 0 && line ("'\"") <= line("$") |
        \         exe "normal g'\"" |
        \     endif |
        \ endif

  " When editing a crontab file, set backupcopy to yes rather than auto. See
  " :help crontab and bug #53437.
  autocmd FileType crontab set backupcopy=yes

augroup END

endif " has("autocmd")


" {{{ vimrc.local
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


" USER SETTINGS BELOW

let mapleader = ","
nnoremap <leader><space> :noh<cr>
nnoremap j gj
nnoremap k gk
" For cycling through buffers
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" I have to stop using these
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

map Q gq " Don't use Ex mode, use Q for formatting

imap <silent> <F9> <ESC>:wa<RETURN>:make<RETURN>
nmap <silent> <F9> :wa<RETURN>:make<RETURN>

set ai                  " Auto indenting
set autochdir           " Might cause plugin problems
set autoread            " Read the file when it's changed from the outside
set backup
set backupdir=~/.vim/backup
set bs=2                " Allow backspacing over everything
set directory=~/.vim/tmp
set history=100
set hlsearch            " Highlight
set ignorecase          " Ignore case when searching
set incsearch           " Incremental
set makeprg=makeobj
set mouse=a             " Enable for all modes
set nocompatible        " Obviously
set number              " Line numbering
set numberwidth=3       " Do not use an annoyingly wide number line column
set ruler               " Show cursor position
set scrolloff=7         " Always keep some context visible
set shiftwidth=4
set showcmd             " Display incomplete commands
set showmatch
set showmatch           " Show matching brackets
set smartcase
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.lo,.pdf
set tabpagemax=15       " ?
set tabstop=4
set viminfo='20,\"500,%   " Keep a .viminfo file.
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplUseSingleClick = 1

autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

autocmd FileType fortran set tabstop=4|set shiftwidth=4|set expandtab
autocmd FocusLost * :wa
au BufNewFile,BufRead *.tex	set ft=tex
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl set ft=glsl

command SetGLSLFileType call SetGLSLFileType()
function SetGLSLFileType()
  for item in getline(1,10)
    if item =~ "#version 400"
      execute ':set filetype=glsl400'
      break
    endif
    if item =~ "#version 330"
      execute ':set filetype=glsl330'
      break
    endif
  endfor
endfunction
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl SetGLSLFileType


" vim: set fenc=utf-8 tw=80 sw=2 sts=2 et :
