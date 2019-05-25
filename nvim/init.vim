call plug#begin()

" Functionality & Utility
Plug 'kien/ctrlp.vim'
Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'dylanaraps/wal.vim'

" Theming & Aesthetics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nightsense/office'

" Recommendations
Plug 'Shougo/deoplete.nvim'

" Language compatibility
Plug 'neoclide/vim-jsx-improve'
Plug 'vim-ruby/vim-ruby'

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
set colorcolumn=80
set hlsearch
" When using the WAL colorscheme, disable termguicolors
"" colorscheme office-dark
colorscheme gruvbox
"" Enable true 24-bit colour
" set termguicolors
"colorscheme wal
set background=dark
set cursorline
set wildmenu
" set the cursor to the traditional vim cursor
set guicursor=
" ENable modeline
set modeline
set t_Co=256

setlocal foldmethod=syntax
noremap <silent><c-l> :nohlsearch<cr>
      \:syntax sync fromstart<cr>
      \<c-l>

set nofoldenable
set foldnestmax=4
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
