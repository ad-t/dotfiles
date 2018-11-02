call plug#begin()

" FUNCTIONS
" For neovim-plugins (https://github.com/c0r73x/neotags.nvim/issues/7)
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" Functionality & Utility
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'donRaphaco/neotex', { 'for': 'tex' }
" Plug 'dylanaraps/wal.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'ngmy/vim-rubocop'
Plug 'jamessan/vim-gnupg'
" Grammar checker
" Plug 'rhysd/vim-grammarous'

" Theming & Aesthetics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nightsense/office'

" Recommendations
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Plug 'c0r73x/neotags.nvim', { 'do': function('DoRemote') }
Plug 'ludovicchabant/vim-gutentags'

" Language compatibility
Plug 'neoclide/vim-jsx-improve'
Plug 'vim-ruby/vim-ruby'

" Linters
Plug 'nvie/vim-flake8'

call plug#end()

filetype plugin indent on
filetype plugin on

let g:airline_powerline_fonts = 1
let g:airline_theme='base16'

set autoindent
set mouse=a
set ruler
set shiftwidth=2
set expandtab
set number
set colorcolumn=100
set hlsearch
" When using the WAL colorscheme, disable termguicolors
"" colorscheme office-dark
colorscheme gruvbox
"" Enable true 24-bit colour
set termguicolors
"colorscheme wal
set background=dark
set cursorline
set wildmenu
" set the cursor to the traditional vim cursor
set guicursor=
" Enable modeline
set modeline
" change the current working directory of the window dependent on what
" file is currently opened in the window
" set autochdir

setlocal foldmethod=syntax
noremap <silent><c-l> :nohlsearch<cr>
      \:syntax sync fromstart<cr>
      \<c-l>

set nofoldenable
set foldnestmax=1
set foldmethod=indent

imap kj <esc>
imap jk <esc>

noremap <UP> <NOP>
noremap <DOWN> <NOP>
noremap <LEFT> <NOP>
noremap <RIGHT> <NOP>
nnoremap K :tabprevious<CR>
nnoremap J :tabnext<CR>

nnoremap <c-c> :! ./compile.sh <cr>
nnoremap <F8> :NERDTreeToggle<CR>
nnoremap <c-i> :GrammarousCheck<CR>

" Neotags Config
let g:neotags_enabled = 1

" Deoplete Config
let g:deoplete#enable_at_startup = 1

" NERDTree Config
let g:NERDTreeWinPos = "right"
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" vim-flake8 config - map linter to F3 and go back to previous window
autocmd FileType python map <buffer> <F3> :call Flake8()<CR><c-w><c-p>
autocmd FileType ruby map <buffer> <F3> :RuboCop -a<CR><c-w><c-p>

" fix problems with working directory
" set autochdir
" fzf fuzzy searching
nnoremap <C-p> :Files .<Cr>
nmap ; :Buffers<CR>
