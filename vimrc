" Steve Harris
" 2020-05-03
set nocompatible	" disable compaibility to old 
set nowrap
set ignorecase 		" case insensitive matching
set backup
set history=50
set incsearch
set relativenumber
set cursorline
set showmatch		" show matching brackets
set hlsearch		" highlight search results
set tabstop=4		" tab column
set softtabstop=4	" soft tabs column
set expandtab		" convert tabs to whitespace 
set shiftwidth=4	" width for autoindents
set autoindent		" indent a new line the same amount
set number		" add line numbers

syntax on
let mapleader = "," 


filetype plugin indent on	" allows auto-indenting by file type
syntax on		" syntax highlighting

call plug#begin()

Plug 'jalvesaq/Nvim-R'
Plug 'scrooloose/nerdtree'

call plug#end()


" open nerd tree using sublimetext short cut
" nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>
