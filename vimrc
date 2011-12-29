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

set hidden
set history=1000
set wildmenu " tab completion for menu

set scrolloff=3 " Context when in the limit of a buffer
set number

set nowrap
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set backspace=indent,eol,start    " backspace through everything in insert mode

let mapleader=","

map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h

map <leader>ga :CommandTFlush<cr>\|:CommandT app<cr>
map <leader>gj :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT app/assets/stylesheets<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT vendor/plugins<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

nnoremap <leader><leader> <c-^>

set backupdir=~/.vim/_backup
set directory=~/.vim/_temp

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set list listchars=tab:\ \ ,trail:·

set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%{fugitive#statusline()}%=%-19(%3l,%02c%03V%) " From Gary Bernhardt


let g:CommandTMaxHeight=10

colorscheme solarized

" Running tests from Gary Bernhardt

function! RunTests(filename)
    :w
    :silent
    if filereadable("script/test")
        exec ":!script/test " . a:filename
    elseif filereadable("Gemfile")
        exec ":!bundle exec rspec " . a:filename
    else
        exec ":!rspec " . a:filename
    end
endfunction

function! SetTestFile()
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

map <leader>T :call RunTestFile()<cr>
map <leader>t :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>

