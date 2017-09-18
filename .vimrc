set nocompatible
let mapleader = ","

"The-NERD-Commenter {{{
let g:NERDCustomDelimiters ={
    \ 'cuda': { 'left': '//', 'leftAlt': '/*', 'rightAlt': '*/' }
\ }
"}}}

filetype off
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"Plugin 'gmarik/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'rdnetto/YCM-Generator'
"Plugin 'scrooloose/nerdcommenter'
"call vundle#end()

filetype plugin indent on
syntax on
set hlsearch
set autowrite
set incsearch
set viminfo='50,\"500
set history=50
set wildmenu
set wildmode=longest:full,full
set showmatch
set showcmd
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set backspace=indent,eol,start
set nojoinspaces
set clipboard=unnamed
set number
set mouse=a
set tags=./tags;

"Key mapping {{{
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
nmap <Space> :set nohlsearch<Enter>
"nmap <C-m> :make<Enter>
"}}}

"Find makefile location {{{
function GetMakefilePath()
    let l:fname = "Makefile"
    let l:path = "./"
    let l:suffixes = ["", "../bin/", "../build/"]
    let l:depth = 1
    while depth < 4
        for l:p in l:suffixes
            let l:curpath = l:path . l:p
            if filereadable(l:curpath . l:fname)
                return simplify(l:curpath)
            endif
        endfor
        let l:depth += 1
        let l:path = "../" . l:path
    endwhile
    return "./"
endfunction
let &makeprg = "make -C " . GetMakefilePath()

function CMakeBuildType(...)
    let l:builddir = GetMakefilePath()
    if filereadable(l:builddir . "CMakeCache.txt")
        if a:0 < 1
            let l:buildtype = system("cmake -N -L '" . l:builddir . "' \| sed -n '/CMAKE_BUILD_TYPE:/s/.*=//p'")
            let l:buildtype = substitute(l:buildtype, '\v^[\s\n]*(.{-})[\s\n]*$', '\1', '')
            echo "Current build type: " . l:buildtype . " (Build dir: " . l:builddir . ")"
        else
            execute "!cmake -DCMAKE_BUILD_TYPE=" . a:1 . " '" . l:builddir . "'"
        endif
    else
        let l:runcmake = confirm("CMake cache not found, run CMake in '" . l:builddir . "'?", "&Yes\n&No", 2)
        if l:runcmake == 1
            let l:cmakeargs = ""
            if a:0 >= 1
                let l:cmakeargs = "-DCMAKE_BUILD_TYPE=" . a:1
            endif
            execute "!cd '" . l:builddir . "' && cmake " . l:cmakeargs . "'" . getcwd() . "'"
        endif
    endif
endfunction
"}}}
