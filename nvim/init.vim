call plug#begin()

" FUNCTIONS
" For neovim-plugins (https://github.com/c0r73x/neotags.nvim/issues/7)
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" colourschemes
Plug 'dylanaraps/wal.vim'
Plug 'w0ng/vim-hybrid'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'

" aesthetics
Plug 'maxmellon/vim-jsx-pretty'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'

" functionality
Plug 'scrooloose/nerdtree'
Plug 'sirver/ultisnips'
Plug 'jamessan/vim-gnupg'
Plug 'moll/vim-bbye'
Plug 'tomtom/tcomment_vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'

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
set number
set hlsearch
set cursorline
set wildmenu
" set the cursor to the traditional vim cursor
set guicursor=
set modeline
set t_Co=16
set scrolloff=8
colorscheme gruvbox
" set termguicolors
" let base16colorspace=256  " Access colors present in 256 colorspace
" let g:hybrid_custom_term_colors = 1

syntax enable
" This line below needs to be after syntax on, otherwise the theme overrides
" the setting
set background=dark
" highlight clear LineNr
highlight Normal ctermbg=0
highlight clear SignColumn
" an added line
highlight clear GitGutterAdd
highlight GitGutterAdd ctermbg=0
" a changed line
highlight clear GitGutterChange
highlight GitGutterChange ctermbg=0
" at least one removed line
highlight clear GitGutterDelete
highlight GitGutterDelete ctermbg=0
" a changed line followed by at least one removed line
highlight clear GitGutterChangeDelete
highlight GitGutterChangeDelete ctermbg=0

setlocal foldmethod=syntax
noremap <silent><c-l> :nohlsearch<cr>
      \:syntax sync fromstart<cr>
      \<c-l>

" lightline
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
set noshowmode

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
nnoremap <c-p> :FZF .<Cr>
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

" use vim-jsx-pretty over polyglot 
let g:polyglot_disabled = ['jsx']

" coc linter system
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]
