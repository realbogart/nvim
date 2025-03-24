"
" Set leader key to Space
"

let mapleader = " "
let maplocalleader = " "

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
" Change forward / backward keys
"

nmap ä [
nmap ö ]
omap ä [
omap ö ]
xmap ä [
xmap ö ]

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
" Restore cursor on exit
"

autocmd VimLeave * set guicursor=a:ver25-Cursor-lCursor-blinkwait1000-blinkon100-blinkoff100
