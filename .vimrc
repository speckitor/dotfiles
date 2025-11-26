syntax on
set number
set relativenumber
set cursorline
set noesckeys
set updatetime=250
set incsearch
set ignorecase
set smartcase
set scrolloff=7
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamedplus
set splitbelow
set splitright
set list
set listchars=tab:>-,space:·,multispace:···\|
let mapleader=" "

vnoremap ; :
vnoremap ; :
nnoremap ; :
nnoremap ; :

nnoremap <leader>f <cmd>Ex<CR>

nnoremap <Esc> <cmd>nohlsearch<CR>
tnoremap <Esc> <C-\\><C-n>

colorscheme retrobox
set background=dark
