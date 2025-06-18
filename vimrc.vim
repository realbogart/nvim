"
" Set leader key to Space
"

let mapleader = " "
let maplocalleader = " "

"
" Disable Space
"

nnoremap <silent> <Space> <Nop>
vnoremap <silent> <Space> <Nop>

"
" Wrap around quickfix list
"

command! Cnext try | cnext | catch | cfirst | catch | endtry
command! Cprev try | cprev | catch | clast | catch | endtry

command! Lnext try | lnext | catch | lfirst | catch | endtry
command! Lprev try | lprev | catch | llast | catch | endtry

cabbrev cnext Cnext
cabbrev cprev Cprev
cabbrev lnext Lnext
cabbrev lprev Lprev

"
" Paste after/before from yank register (normal and visual)
"

nnoremap <silent> <leader>p "0p
vnoremap <silent> <leader>p "0p
nnoremap <silent> <leader>P "0P
xnoremap <silent> <leader>P "0P

"
" Move cursor within insert mode
"

inoremap <silent> <C-h> <Left>
inoremap <silent> <C-j> <Down>
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-l> <Right>

"
" Better movement when no count is provided
"

nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

"
" Save/quit mappings
"

nnoremap <silent> <leader>z ZZ<CR>
nnoremap <silent> <leader>q :qa!<CR>

"
" Invert find characters
"

nnoremap <silent> ; ,
nnoremap <silent> , ;

"
" Center cursor when navigating
"

nnoremap <silent> <C-u> <C-u>zz
nnoremap <silent> <C-d> <C-d>zz
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv

"
" Quickfix navigation
"

nnoremap <silent> ]f :cnext<CR>
nnoremap <silent> [f :cprev<CR>

" 
" Highlight on yank
"

augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END

"
" Clear search highlights with <Esc>
"

nnoremap <silent> <Esc> :noh<CR>

"
" Change forward / backward keys
"

nmap ä [
nmap ö ]
omap ä [
omap ö ]
xmap ä [
xmap ö ]

"
" Move selected block up and down
"

vnoremap <silent> K :m '<-2<CR>gv=gv
vnoremap <silent> J :m '>+1<CR>gv=gv

"
" Basic UI and editing options
"

set number                " Show absolute line numbers
set relativenumber        " Show relative numbers
set signcolumn=yes        " Always show the sign column
set hlsearch              " Highlight search results
set mouse=a               " Enable mouse support
set clipboard=unnamed,unnamedplus " Use system clipboard
set breakindent           " Enable break indent
set undofile              " Persistent undo
set ignorecase            " Case insensitive searching
set smartcase             " But use smart case when uppercase letters present
set timeoutlen=300        " Time to wait for a mapped sequence
set completeopt=menuone,noselect " Completion options
set termguicolors         " Enable true color support
set noswapfile            " Disable swapfile
set scrolloff=8           " Keep 8 lines visible when scrolling
set updatetime=50         " Faster completion and swap update
set conceallevel=0        " Show all text normally
set tabstop=2             " Number of spaces per tab
set shiftwidth=0          " Indent using 'tabstop' value
set softtabstop=0         " No extra space when using <Tab> in insert mode
set expandtab             " Use spaces instead of tabs
set fileformats=unix,dos  " Allow Unix and DOS file formats

"
" Exit insert mode by typing "kj"
"

inoremap <silent> kj <Esc>

"
" Save file with <C-s> in Normal, Visual, and Insert modes
"

nnoremap <silent> <C-s> :w<CR>
vnoremap <silent> <C-s> :w<CR>
inoremap <silent> <C-s> <Esc>:w<CR>a

"
" Restore cursor on exit
"

autocmd VimLeave * set guicursor=a:ver25-Cursor-lCursor-blinkwait1000-blinkon100-blinkoff100
