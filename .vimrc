syntax on " highlight syntax
set rtp^="/Users/yareque/.opam/cs3110/share/ocp-indent/vim" " ocaml stuff
set backspace=indent,eol,start
set nocompatible " make vim not compatible with vi to gain extra functionality
set number " show line numbers
set relativenumber
set noswapfile " disable the swapfile
set hlsearch " highlight all results
set smartcase " ignore case in search
set incsearch " show search results as you type
set showcmd " show command as it is being entered
set smartindent
"set timeoutlen=300 ttimeoutlen=300 " shorten key press timeout
set belloff=all " disable beeping on invalid commands
set nowrap
set undodir=~/.vim/undodir
set noswapfile
set nobackup
set undofile
"set clipboard=unnamed

" 1 tab width = 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Clear highlighting on escape in normal mode
" set noesckeys
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Move line up and down in all modes with Option + j/k
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
" commented out to use this combination in YCM to cycle through optoins
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv


call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'
Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ycm-core/YouCompleteMe'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-autoformat/vim-autoformat'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'mbbill/undotree'

call plug#end()

colorscheme onedark
highlight LineNr ctermfg=grey
highlight Visual cterm=reverse guibg=Green
highlight HighlightedyankRegion cterm=reverse gui=reverse

let mapleader = " "
nnoremap <space> <nop>

let g:highlightedyank_highlight_duration = 50
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
let g:ycm_key_list_select_completion = ['<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_auto_hover = -1

let g:ale_completion_enabled = 1
set omnifunc=ale#completion#OmniFunc

nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>dd "_dd

nnoremap <leader>c "_c
vnoremap <leader>c "_c
nnoremap <leader>c "_c
vnoremap <leader>c "_c
nnoremap <leader>s "_s

nnoremap <leader>y "*y
vnoremap <leader>y "*y

nnoremap <leader>p "*p
vnoremap <leader>p "*p
nnoremap <leader>p "*p
vnoremap <leader>p "*p

" format on save
"au BufWrite * :Autoformat
"vnoremap <leader>q :Autoformat<CR>
"nnoremap <leader>q :Autoformat<CR>

nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>d :YcmCompleter GoToDocumentOutline<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
nnoremap <leader>r :YcmCompleter RefactorRename 
vnoremap <leader>q :YcmCompleter Format<CR>
nnoremap <leader>s :YcmCompleter GoToSymbol<CR>
nnoremap <leader>i <plug>(YCMHover)

nnoremap <leader>f :GFiles<CR>
nnoremap <leader>F :Files<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>H :History
nnoremap <leader>c :Commits<CR>
nnoremap <leader>G :Rg<CR>

nnoremap <leader>u :UndotreeToggle<CR>

set grepprg=rg\ --vimgrep\ --smart-case\ --follow
