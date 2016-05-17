set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

let g:airline_powerline_fonts = 1
set laststatus=2
syntax on

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" ONLY FOR VIMTEX VUNDLE PLUGIN
" let g:live_preview_previewer = 'firefox'

let g:airline#extensions#tabline#enables = 1

set autoindent
set mouse=a
set ruler
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set colorcolumn=72
set hlsearch
set t_Co=256
set background=dark

"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
