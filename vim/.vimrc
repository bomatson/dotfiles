" Use Vim Plug
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'          " Smart defaults
Plug 'tpope/vim-fugitive'          " Git integration
Plug 'itchyny/lightline.vim'       " Status bar
Plug 'junegunn/fzf.vim'            " Fuzzy finder (requires fzf installed)
Plug 'morhetz/gruvbox'             " Color scheme

call plug#end()

" Editor Settings
syntax on
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent
set cursorline
set hidden
set clipboard=unnamedplus
set background=dark
colorscheme gruvbox

" Leader key
let mapleader = ","
