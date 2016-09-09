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
map <leader>gt :CommandTFlush<cr>\|:CommandT config/locales<cr>
"map <leader>gt :CommandTFlush<cr>\|:CommandT spec<cr>
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
set wildignore=.o,.obj,.git,node_modules/**

colorscheme solarized

" Running tests from Gary Bernhardt & Francesc Esplugas & Jordi Romero


function! s:send_test(executable)
  let s:executable = a:executable
  if s:executable == ''
    if exists("g:tmux_last_command") && g:tmux_last_command != ''
      let s:executable = g:tmux_last_command
    else
      let s:executable = 'echo "Warning: No command has been run yet"'
    endif
  endif
  call Send_to_Tmux("".s:executable."\n")
  :redraw!
endfunction

function! RunTests(args)
  :write
  :silent !echo;echo;echo;echo;echo
  if filereadable('script/test')
    let spec =  'script/test '
  elseif filereadable('Gemfile')
    let spec = 'bundle exec rspec '
  else
    let spec = 'rspec '
  end
  " Without Send_to_Tmux
  let cmd = ':! time ' . spec . a:args
  execute cmd

  " With Send_to_Tmux
  " let cmd = 'time ' . spec . a:args
  " return s:send_test(cmd)
endfunction

" function! RunTests(filename)
"     " Write the file and run tests for the given filename
"     :w
"     :silent !echo;echo;echo;echo;echo
"     exec ":!bundle exec rspec " . a:filename
" endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
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

" Run this file
map <leader>T :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>t :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>

" Toggle Scratch pad
function! ToggleScratch()
  if expand('%') == g:ScratchBufferName
      quit
  else
      Sscratch
  endif
endfunction

map <leader>s :call ToggleScratch()<CR>


set timeoutlen=500 " This avoids escape lag

let g:Powerline_symbols = 'fancy' " Uses fancy font for powerline


" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

nmap gV `[v`]

:nnoremap <silent> <leader>tr :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

nnoremap <silent> <leader>c :nohl<CR>

execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"--------------- Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_loc_list_height=4
let g:syntastic_aggregate_errors = 1

