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
" set cursorcolumn
set showmatch		" show matching brackets
set hlsearch		" highlight search results
set tabstop=4		" tab column
set softtabstop=4	" soft tabs column
set expandtab		" convert tabs to whitespace 
set shiftwidth=4	" width for autoindents
set autoindent		" indent a new line the same amount
set number		" add line numbers

syntax on		" syntax highlighting
filetype plugin indent on	" allows auto-indenting by file type


let mapleader = " " 
let maplocalleader = "," 


" https://alex.dzyoba.com/blog/vim-revamp/
" Peristent undo
set undodir=~/.vim/undodir
set undofile



" Make sure plugged is installed
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load plug ins
call plug#begin()

Plug 'NLKNguyen/papercolor-theme'

Plug 'tpope/vim-surround' " Vim Surround
Plug 'ctrlpvim/ctrlp.vim' " CtrlP
Plug 'troydm/zoomwintab.vim' " zoom
Plug 'tpope/vim-obsession' " session management

" In preference to nerdtree
Plug 'tpope/vim-vinegar'    " Vinegar
" Plug 'scrooloose/nerdtree'

" Git
Plug 'jreybert/vimagit'

" R
Plug 'jalvesaq/Nvim-R'

" CursorLineCurrentWindow
Plug 'inkarkat/vim-CursorLineCurrentWindow'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" notational velocity
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'alok/notational-fzf-vim'

" tabular plugin is used to format tables
Plug 'godlygeek/tabular'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'reedes/vim-pencil'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'

" Distraction free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

"
Plug 'christoomey/vim-tmux-navigator'

" Tag navigation
Plug 'majutsushi/tagbar' " tag navigation
Plug 'jszakmeister/markdown2ctags'

call plug#end()

" Remap non plug in keys
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
vnoremap <leader>c "*y
vnoremap <leader>p "*p

" Remap plugin keys
nnoremap <Leader>c :close<CR>
nnoremap <Leader>wg :Goyo<CR>
nnoremap <Leader>wl :Limelight!!<CR>
" notatinal-fzf-vim
nnoremap <silent> <c-s> :NV<CR>
" Zoomwintab
nnoremap <C-w>o :ZoomWinTabToggle<CR>
" Session management
let g:session_dir = '~/vim-sessions'
" Session management
exec 'nnoremap <Leader>ss :Obsession ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" Set color schemes
set background=light
colorscheme PaperColor
let g:airline_theme='papercolor'


" NerdTree
" see vim and vinegar comments
" let NERDTreeHijackNetrw=1

" notatinal-fzf-vim
let g:nv_search_paths = ['~/nvalt']

" Pandoc
" let g:pandoc#folding#level = 0

" PlasticBoy markdown
" disable header folding
let g:markdown_fenced_languages = ['bash', 'python', 'R', 'sh']
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
 let g:tex_conceal = ""
 let g:vim_markdown_math = 1

" support front matter of various format
 let g:vim_markdown_frontmatter = 1  " for YAML format
" let g:vim_markdown_toml_frontmatter = 1  " for TOML format
" let g:vim_markdown_json_frontmatter = 1  " for JSON format

" Airline
let g:airline_statusline_ontop=0
let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|markdown|markdown.pandoc|org|rst|tex|text|pandoc'
set laststatus=2    " enables vim-airline.

" CtrlP
"let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript',
"                          \ 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_extensions = ['tag', 'buffertag', 'dir', 'line', 'bookmarkdir']

" Markdown and ctags
" https://stackoverflow.com/questions/58758810/vim-markdown-navigation-with-ctags-using-tagbar-markdown2ctags-with-vim
let g:tagbar_type_pandoc = {
    \ 'ctagstype': 'pandoc',
    \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes --sro=»',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '»',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0
\ }

" Goyo and Limelight
" ==================
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    " silent !tmux set status off
    " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set nospell
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    " silent !tmux set status on
    " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set spell
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" https://github.com/majutsushi/tagbar
" https://github.com/wsdjeg/mdctags.rs
let g:tagbar_type_markdown = {
            \ 'ctagsbin'  : 'mdctags',
            \ 'ctagsargs' : '',
            \ 'kinds'     : [
            \     'a:h1:0:0',
            \     'b:h2:0:0',
            \     'c:h3:0:0',
            \     'd:h4:0:0',
            \     'e:h5:0:0',
            \     'f:h6:0:0',
            \ ],
            \ 'sro'        : '::',
            \ 'kind2scope' : {
            \     'a' : 'h1',
            \     'b' : 'h2',
            \     'c' : 'h3',
            \     'd' : 'h4',
            \     'e' : 'h5',
            \     'f' : 'h6',
            \ },
            \ 'scope2kind' : {
            \     'h1' : 'a',
            \     'h2' : 'b',
            \     'h3' : 'c',
            \     'h4' : 'd',
            \     'h5' : 'e',
            \     'h6' : 'f',
            \}
            \}

