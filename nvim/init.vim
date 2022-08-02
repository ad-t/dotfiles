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
Plug 'sainnhe/gruvbox-material'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'

" aesthetics
Plug 'maxmellon/vim-jsx-pretty'

" use vim-jsx-pretty over polyglot
let g:polyglot_disabled = ['jsx']

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
set t_Co=256
set scrolloff=8
set showtabline=2
set termguicolors
" let base16colorspace=256  " Access colors present in 256 colorspace
let g:hybrid_custom_term_colors = 1

syntax enable
" This line below needs to be after syntax on, otherwise the theme overrides
" the setting
set background=dark
" fix the comments formatting being wrong
let g:gruvbox_italic=1
colorscheme gruvbox-material
highlight clear SignColumn

highlight clear Comment
highlight Comment guifg=#928374 guibg=None

setlocal foldmethod=syntax
noremap <silent><c-l> :nohlsearch<cr>
      \:syntax sync fromstart<cr>
      \<c-l>

" lightline
let g:lightline = {'colorscheme' : 'gruvbox_material'}
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

" nnoremap E :NERDTreeToggle<CR>
" 
" " NERDTree Config
" let g:NERDTreeWinPos = "left"
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p

" fzf fuzzy searching
nnoremap <c-p> :call OpenInFreshWindowOrNewTab()<cr>
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

" coc linter system
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-git',
  \ 'coc-eslint',
  \ 'coc-sh',
  \ 'coc-vimlsp'
  \ ]

" Make FZF open in a new tab every time
function! OpenInFreshWindowOrNewTab()
    if bufname('%') == '' && getbufvar('%', "&modified") == 0
        FZF
    else
        tabnew
        FZF
        " Close the new tab if the find was cancelled.
        if bufname('%') == ''
            tabclose
        endif
    endif
endfunction

" coc keybindings
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" nnoremap <silent> K :call ShowDocumentation()<CR>
