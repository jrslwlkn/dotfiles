syntax on " highlight syntax
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
"set timeoutlen=100 ttimeoutlen=10 " shorten key press timeout
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
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

" Move line up and down in all modes with Control + j/k
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv


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

call plug#end()


colorscheme onedark
highlight LineNr ctermfg=grey
highlight Visual cterm=reverse guibg=Green 
highlight HighlightedyankRegion cterm=reverse gui=reverse

let mapleader = " "
nnoremap <space> <nop>

let g:highlightedyank_highlight_duration = 300
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']

nnoremap <leader>d "*d
nnoremap <leader>y "*y
nnoremap <leader>p "*p
nnoremap d "_d
nnoremap c "_c
nnoremap x "_x

