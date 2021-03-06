"""""""""""""""""""""""""""""
"Vundle BEGIN
"""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'fatih/vim-go'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}
Plugin 'Shougo/neosnippet'
Plugin 'scrooloose/syntastic'
Plugin 'The-NERD-Commenter'

" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""
" Vundle END
"""""""""""""""""""""""""""""

source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin
" Restore the last edit position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set guioptions-=m  "remove menu bar
"set guioptions-=T  "remove toolbar
"set guioptions-=r  "remove right-hand scroll bar
"set guioptions-=L  "remove left-hand scroll bar

" 启动时即进入插入模式
"exe "startinsert"
"display EOF marker
"set list
" do not insert newline at the end of file 
"set fileformats+=dos
" set asm file font
"autocmd BufEnter  *.asm set guifont=Courier_New:h12
" default font
"set guifont=Courier_new:h10:b:cDEFAULT
"set guifont=Consolas:h12:cDEFAULT

" enable syntax highlighting
syntax on
" enable filetype detection and plugin loading
filetype plugin on

"au BufEnter *.hs compiler ghc
"
""指定ghc编译器 如果报错或者安装了多个编译器
""let g:ghc="C:/Program Files (x86)/Haskell Platform/2013.2.0.0/bin/ghc.exe" 
"
""设置文档浏览器
"let g:haddock_browser="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
"
""指定文档位置，否则报错
"let g:haddock_docdir = "C:/Program Files (x86)/Haskell Platform/2013.2.0.0/doc/html/"

set encoding=utf-8

"解决console输出乱码
"language messages zh_cn.utf-8

"""""""""""""""""""""""""""""
"显示空白行和制表符
"""""""""""""""""""""""""""""
set list listchars=tab:»\ ,trail:.
":set list listchars=trail:.


"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.

let g:neocomplete#enable_at_startup = 1
"set guifont=PowerlineSymbols\ for\ Powerline
let g:Powerline_symbols='fanyc'

"colorscheme desert
set t_Co=256
"colorscheme desert256   " tty
colorscheme gruvbox
set background=dark
"let g:gruvbox_contrast_dark='hard'

"set makeprg=nmake
set grepprg=ack\ -k
set tags=tags;
set autochdir
set noswapfile
set nobackup
set undodir=~/.undodir
set nowritebackup
set noeb
set number
set nocompatible
set laststatus=2    " always have status-line
set rnu             " enable relative-line-number
"set cursorcolumn    " hightlight current column
set cursorline

filetype on
" syntax highlight
au BufNewFile,BufRead *.x set filetype=lex
au BufNewFile,BufRead *.y set filetype=yacc
au BufNewFile,BufRead *.hla set filetype=hla
au BufNewFile,BufRead *.asm set filetype=nasm
au BufNewFile,BufRead *.inc set filetype=nasm
au bufreadpre,bufRead *.bnf set ft=bnf
au BufNewFile,BufRead *.ebnf set filetype=ebnf

set tabstop=4                   "tab: 8 spaces
set expandtab                   "Always uses spaces instead of tabs
set softtabstop=4               "Insert 4 spaces when tab is pressed
set shiftwidth=4                "An indent is 4 spaces
set smarttab                    "Indent instead of tab at start of line
set shiftround                  "Round spaces to nearest shiftwidth multiple
set nojoinspaces                "disable convert spaces to tabs
set backspace=2                 "set backspace behavior
