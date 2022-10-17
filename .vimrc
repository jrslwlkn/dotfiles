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
set completeopt-=preview

" 1 tab width = 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4


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
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'

call plug#end()


colorscheme onedark
highlight LineNr ctermfg=grey
highlight Visual cterm=reverse guibg=Green
highlight HighlightedyankRegion cterm=reverse gui=reverse

let g:highlightedyank_highlight_duration = 50
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
let g:ycm_key_list_select_completion = ['<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']
let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")
let g:ycm_auto_hover = -1
let g:ale_completion_enabled = 1
let g:ycm_add_preview_to_completeopt = 0

set omnifunc=ale#completion#OmniFunc

let mapleader = " "
nnoremap <space> <nop>

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

" Go To Definition/Declaration
nnoremap <leader>g :YcmCompleter GoTo<CR>
" Find Usages/References
nnoremap <leader>d :YcmCompleter GoToDocumentOutline<CR>
" Get Type
nnoremap <leader>t :YcmCompleter GetType<CR>
" Refactor Rename
nnoremap <leader>r :YcmCompleter RefactorRename 
" Format Selection (not strictly the selection but good enough)
vnoremap <leader>q :YcmCompleter Format<CR> gv=`>
" Go To Symbol in File
nnoremap <leader>s :YcmCompleter GoToSymbol<CR>
" Show Stub Information
nnoremap <leader>i <plug>(YCMHover)
" Search in Git Files by Filename
nnoremap <leader>f :GFiles<CR>
" Search Global Files by Filename
nnoremap <leader>F :Files<CR>
" Search Global Files by File Contents
nnoremap <leader>G :Rg<CR>
" Search Recent Files by Filename
nnoremap <leader>h :History<CR>
" Search Command History with : and Search the search history with /
nnoremap <leader>H :History
" Show Commits
nnoremap <leader>c :Commits<CR>
" Toggle Undo Tree
nnoremap <leader>u :UndotreeToggle<CR>


nnoremap <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader><leader> :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <leader>j :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <leader>k :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <leader>l :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <leader>; :lua require("harpoon.ui").nav_file(4)<CR>

nnoremap <leader><C-i> :lua require("harpoon.ui").nav_next()<CR>
nnoremap <leader><C-o> :lua require("harpoon.ui").nav_prev()<CR>

set grepprg=rg\ --vimgrep\ --smart-case\ --follow
