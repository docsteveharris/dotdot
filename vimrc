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

Plug 'NLKNguyen/papercolor-theme'

Plug 'tpope/vim-surround' " Vim Surround
" 2020-10-06 trying without this since you have FZF working with Rg
" Plug 'ctrlpvim/ctrlp.vim' " CtrlP
Plug 'troydm/zoomwintab.vim' " zoom
Plug 'tpope/vim-obsession' " session management

" In preference to nerdtree
Plug 'tpope/vim-vinegar'    " Vinegar
" Plug 'scrooloose/nerdtree'

" Git
" Plug 'jreybert/vimagit'
Plug 'tpope/vim-fugitive'

" Conqueror of Completion
" https://github.com/neoclide/coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" R
" 2020-07-30 needed to update the python remote async plugins after these
" installs; see https://github.com/jacobsimpson/nvim-example-python-plugin
" :UpdateRemotePlugins
" Plug 'ncm2/ncm2'
" Plug 'roxma/nvim-yarp'
Plug 'jalvesaq/Nvim-R'
Plug 'chrisbra/csv.vim'

" Plug 'gaalcaras/ncm-R'
" Optional: for snippet support
" Plug 'sirver/UltiSnips'

" CursorLineCurrentWindow
Plug 'inkarkat/vim-CursorLineCurrentWindow'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" FZF using the brew install of fzf
" 2020-10-14 use the brew installed system fzf rather than this local one
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug '/usr/local/opt/fzf'
" Then enable the fzf plugin
Plug 'junegunn/fzf.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" notational velocity (wrapper for fzf)
Plug 'alok/notational-fzf-vim'

"

" tabular plugin is used to format tables
Plug 'godlygeek/tabular'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'reedes/vim-pencil'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'itspriddle/vim-marked'

" Distraction free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

"
Plug 'christoomey/vim-tmux-navigator'

" Tag navigation
Plug 'majutsushi/tagbar' " tag navigation
Plug 'jszakmeister/markdown2ctags'

" Multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Autosave
Plug '907th/vim-auto-save', {'branch': 'master'}

" https://github.com/lervag/vimtex
Plug 'lervag/vimtex'

" https://vimawesome.com/plugin/the-nerd-commenter
" Plug 'preservim/nerdcommenter' "end of line comment <Leader>cA
Plug 'tpope/vim-commentary'

call plug#end()
" ===========

" Remap non plug in keys
" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" leader cd will move to the current directory; ?safer than autochdir
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

vnoremap <leader>c "+y
vnoremap <leader>p "+p

" move in long lines
nnoremap k gk
nnoremap j gj

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
"
" Open vimagit pane
" https://jakobgm.com/posts/vim/git-integration/
" nnoremap <leader>gs :Magit<CR>       " git status

" as per https://github.com/neoclide/coc.nvim
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

nnoremap <Leader>cc :close<CR>
nnoremap <Leader>wg :Goyo<CR>
nnoremap <Leader>wl :Limelight!!<CR>
"

" vimtex
let g:tex_flavor = 'latex'

" Terminal mode
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

" nvim-R and friends
" ==================
let R_hl_term = 0
" enable ncm2 for all buffers
" autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
" set completeopt=noinsert,menuone,noselect


" optional vimrc tips for ncm2
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
" set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
" inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
" inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
nnoremap <S-CR> <Plug>REDSendLine
inoremap <S-CR> <Plug>REDSendLine

" FZF and Ripgrep
" https://dev.to/haydenrou/optimizing-your-workflow-with-fzf-ripgrep-2eai
let g:rg_derive_root='true'
" https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow

" notatinal-fzf-vim
" =================
nnoremap <silent> <C-s> :NV<CR>

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

" NerdTree
" see vim and vinegar comments
" let NERDTreeHijackNetrw=1

" 2020-09-14 this is also available via iaWriter app
" notatinal-fzf-vim
let g:nv_search_paths = ['~/iaWriter/Notes']

" String. Set to '' (the empty string) if you don't want an extension appended by default.
" Don't forget the dot, unless you don't want one.
let g:nv_default_extension = '.md'

" String. Default is first directory found in `g:nv_search_paths`. Error thrown
"if no directory found and g:nv_main_directory is not specified
"let g:nv_main_directory = g:nv_main_directory or (first directory in g:nv_search_paths)

" Dictionary with string keys and values. Must be in the form 'ctrl-KEY':
" 'command' or 'alt-KEY' : 'command'. See examples below.
let g:nv_keymap = {
                    \ 'ctrl-s': 'split ',
                    \ 'ctrl-v': 'vertical split ',
                    \ 'ctrl-t': 'tabedit ',
                    \ }

" String. Must be in the form 'ctrl-KEY' or 'alt-KEY'
let g:nv_create_note_key = 'ctrl-x'

" String. Controls how new note window is created.
let g:nv_create_note_window = 'vertical split'

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
" let g:ctrlp_extensions = ['tag', 'buffertag', 'dir', 'line', 'bookmarkdir']
" let g:ctrlp_extensions = ['dir']

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


set rtp+=/usr/local/opt/fzf

