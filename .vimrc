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
set clipboard="unnamedplus"
set tabstop=4
set shiftwidth=4
set expandtab
set splitbelow
set splitright
set list
set listchars="tab:>-,space:·,multispace:···|"

vnoremap ; :
vnoremap ; :
nnoremap ; :
nnoremap ; :

nnoremap <Esc> <cmd>nohlsearch<CR>
tnoremap <Esc> <C-\\><C-n>

colorscheme sorbet
