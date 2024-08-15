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
" Restore cursor on exit
"

autocmd VimLeave * set guicursor=a:ver25-Cursor-lCursor-blinkwait1000-blinkon100-blinkoff100
