set nocompatible

syntax enable

set encoding=utf-8

call pathogen#infect() " Pathogen

set showcmd " incomplete commands
filetype plugin indent on

set hlsearch " highlight
set incsearch " incremental
set ignorecase " case insensitive
set smartcase " case sensitive if capital letters

set nowrap
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

let mapleader=","

map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
