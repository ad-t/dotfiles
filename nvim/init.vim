call plug#begin()

" FUNCTIONS
" For neovim-plugins (https://github.com/c0r73x/neotags.nvim/issues/7)
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" searching
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" colourschemes
Plug 'dylanaraps/wal.vim'
Plug 'w0ng/vim-hybrid'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'morhetz/gruvbox'

" aesthetics
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'

" functionality
Plug 'scrooloose/nerdtree'
Plug 'sirver/ultisnips'
Plug 'jamessan/vim-gnupg'
Plug 'moll/vim-bbye'
Plug 'tomtom/tcomment_vim'

" git
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

call plug#end()

filetype plugin indent on
filetype plugin on

" True gui colors in terminal
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set autoindent
set mouse=a
set ruler
set shiftwidth=2
set expandtab
set number relativenumber
set hlsearch
set cursorline
set wildmenu
" set the cursor to the traditional vim cursor
set guicursor=
set modeline
set t_Co=256
set background=dark
set scrolloff=50
colorscheme gruvbox
" let g:hybrid_custom_term_colors = 1

syntax on
" This line below needs to be after syntax on, otherwise the theme overrides
" the setting
highlight Normal ctermbg=NONE
highlight clear SignColumn

setlocal foldmethod=syntax
noremap <silent><c-l> :nohlsearch<cr>
      \:syntax sync fromstart<cr>
      \<c-l>

" airline
let g:airline_powerline_fonts = 0
let g:airline_theme='base16'

set nofoldenable
set foldmethod=indent

imap kj <esc>
imap jk <esc>

noremap <UP> <NOP>
noremap <DOWN> <NOP>
noremap <LEFT> <NOP>
noremap <RIGHT> <NOP>
nnoremap K :tabprevious<CR>
nnoremap J :tabnext<CR>

nnoremap E :NERDTreeToggle<CR>

" NERDTree Config
let g:NERDTreeWinPos = "left"
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

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

" gutentags config
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" bring up the neovim terminal
nnoremap <Leader>` :vsp <CR> :terminal<CR>A

" ale linter config
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
