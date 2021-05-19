" Steve Harris
" 2020-05-03
set nocompatible	" disable compaibility to old 

" best for prose
set wrap
set linebreak
set ignorecase 		" case insensitive matching

" as per https://github.com/neoclide/coc.nvim
set nobackup
set nowritebackup
set history=50
set cmdheight=2
set updatetime=300
set shortmess+=c

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
set number		    " add line numbers
set hidden          " https://vi.stackexchange.com/questions/18940/how-to-use-fzf-buffers-files-commands-from-vim-terminal-buffer
set modifiable      " https://stackoverflow.com/questions/5745506/vim-modifiable-is-off

" More natural split opening
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

" https://neovim.io/doc/user/provider.html#clipboard
set clipboard+=unnamedplus

syntax on		" syntax highlighting
filetype plugin indent on	" allows auto-indenting by file type


" https://github.com/ncm2/ncm2#requirements
let g:python3_host_prog='/Users/steve/.pyenv/shims/python3'
" let g:python_host_prog='/Users/steve/.pyenv/shims/python'

" Leader key and Local Leader key
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
" =============
call plug#begin()

Plug 'tpope/vim-surround' " Vim Surround
Plug 'tpope/vim-obsession' " session management
Plug 'tpope/vim-vinegar'    " Vinegar in preference to nerdtree
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

" FZF using the brew install of fzf
" 2020-10-14 use the brew installed system fzf rather than this local one
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kassio/neoterm'
" Conqueror of Completion https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'troydm/zoomwintab.vim' " zoom
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multiple cursors
Plug 'NLKNguyen/papercolor-theme'
Plug 'inkarkat/vim-CursorLineCurrentWindow'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular' " tabular plugin is used to format tables
Plug 'plasticboy/vim-markdown'
Plug 'reedes/vim-pencil'
Plug 'christoomey/vim-tmux-navigator'
Plug 'majutsushi/tagbar' " tag navigation
Plug 'jszakmeister/markdown2ctags'
Plug '907th/vim-auto-save', {'branch': 'master'} " Autosave

" Org mode and outlining stuff
" https://github.com/axvr/org.vim
Plug 'axvr/org.vim'

call plug#end()
" ===========

" Remap non plug in keys
" ======================
"
" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" leader cd will move to the current directory; ?safer than autochdir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" yank and paste from the system clipboard
vnoremap <leader>c "+y
vnoremap <leader>p "+p
" move in long lines
nnoremap k gk
nnoremap j gj
"
" Splits and tips
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" https://vi.stackexchange.com/questions/3686/copy-the-full-path-of-current-buffer-to-clipboard
:command! CopyBuffer let @+ = expand('%:p:h')
:nnoremap <Leader>pp :let @+=expand('%:p:h')<CR>

" Remap plugin keys
" =================
" remove this as it clashes with vinegar -
" https://github.com/vimwiki/vimwiki/issues/937
nmap <Nop> <Plug>VimwikiRemoveHeaderLevel

" as per https://github.com/neoclide/coc.nvim
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" close all other buffers https://stackoverflow.com/a/42071865
nnoremap <Leader>bda :%bd\|e#\|bd#<CR>
nnoremap <Leader>cc :close<CR>
"

" Terminal mode
" =============
" https://neovim.io/doc/user/nvim_terminal_emulator.html
" To map <Esc> to exit terminal-mode:
:tnoremap <Esc> <C-\><C-n>

" terminal remapping
" To simulate |i_CTRL-R| in terminal-mode:
" :tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" To use `ALT+{h,j,k,l}` to navigate windows from any mode:
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

" FZF actions
" ===========
" nnoremap <silent> <C-f> :Files<CR>
" nnoremap <silent> <Leader>f :Rg<CR>
" nnoremap \ :Rg<CR>
" nnoremap <A-p> :Rg<cr> " search across current dir
" nnoremap <C-p> :Files<cr>
"
" search across current dir
nnoremap <Leader>ff :Rg<cr>
" files only
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <Leader>fb :Buffers<cr>
nnoremap <Leader>fs :BLines<cr>
nnoremap <Leader>fh :History<cr>

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right / window
let g:fzf_layout = { 'down': '40%' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '15new' }

" vimwiki
let g:vimwiki_list = [{'path': '~/notes/', 'syntax': 'markdown', 'ext': '.md'}]

" FZF and Ripgrep
" https://dev.to/haydenrou/optimizing-your-workflow-with-fzf-ripgrep-2eai
let g:rg_derive_root='true'
" https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow

" Using tabs as layouts and buffers as tabs
" https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Zoomwintab
nnoremap <C-w>o :ZoomWinTabToggle<CR>

" Session management
let g:session_dir = '~/vim-sessions'
" Session management
exec 'nnoremap <Leader>ss :Obsession ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" vim-auto-save
" =============

let g:auto_save = 0
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
augroup END

" Set color schemes
" set background=light
set background=dark
colorscheme PaperColor
let g:airline_theme='papercolor'

" PlasticBoy markdown
" disable header folding
let g:vim_markdown_folding_disabled = 0
let g:markdown_fenced_languages = ['bash', 'python', 'R', 'sh']
let g:vim_markdown_toc_autofit = 1

" org.vim
let g:org_clean_folds = 1
let g:org_state_keywords = ['TODO', 'DONE', 'NOTE']

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

 let g:vim_markdown_math = 1

" support front matter of various format
 let g:vim_markdown_frontmatter = 1  " for YAML format
" let g:vim_markdown_toml_frontmatter = 1  " for TOML format
" let g:vim_markdown_json_frontmatter = 1  " for JSON format

" Airline
let g:airline_statusline_ontop=0
let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|markdown|markdown.pandoc|org|rst|tex|text|pandoc'
set laststatus=2    " enables vim-airline.

" Marked
let g:marked_app = "Marked"

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


set rtp+=/usr/local/opt/fzf

