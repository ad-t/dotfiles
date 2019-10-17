call plug#begin()

" FUNCTIONS
" For neovim-plugins (https://github.com/c0r73x/neotags.nvim/issues/7)
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" Functionality & Utility
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'donRaphaco/neotex', { 'for': 'tex' }
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'dylanaraps/wal.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'ngmy/vim-rubocop'
Plug 'jamessan/vim-gnupg'
Plug 'moll/vim-bbye'
Plug 'airblade/vim-gitgutter'
" Grammar checker
" Plug 'rhysd/vim-grammarous'

" Theming & Aesthetics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'nightsense/office'

" Autocompletion using language servers
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Recommendations
" Plug 'ludovicchabant/vim-gutentags'

" Language compatibility
Plug 'neoclide/vim-jsx-improve'
Plug 'vim-ruby/vim-ruby'

" Linters
" Plug 'nvie/vim-flake8'

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
" set number relativenumber
set number
" set colorcolumn=100
set hlsearch
" When using the WAL colorscheme, disable termguicolors
"" colorscheme office-dark
" colorscheme gruvbox
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

set t_Co=16

syntax on
"" Enable true 24-bit colour
" set termguicolors
colorscheme wal_custom
" colorscheme wal

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
nnoremap E :NERDTreeToggle<CR>
nnoremap <c-i> :GrammarousCheck<CR>

" Neotags Config
let g:neotags_enabled = 1

" Deoplete Config
let g:deoplete#enable_at_startup = 1

" NERDTree Config
let g:NERDTreeWinPos = "left"
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

" Vimtex config
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
autocmd FileType tex,latex :VimtexCompile
" autocmd FileType tex,latex :VimtexView

" Polyglot config
let g:polyglot_disabled = ['latex']

" ultisnips config
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"
let g:UltiSnipsSnippetDirectories=["~/.config/nvim/UltiSnips", "UltiSnips"]

" delete buffers
nnoremap <Leader>q :Bdelete<CR>

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'go': ['/home/adam/go/bin/go-langserver'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" gutentags config
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" bring up the neovim terminal
nnoremap <Leader>` :terminal<CR>A
