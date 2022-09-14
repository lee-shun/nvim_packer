" ===
" === convert spaces
" ===
fun! Tab2Space()
    exec "set expandtab"
    exec "%retab!"
endfun

fun! Space2Tab()
    exec "set noexpandtab"
    exec "%retab!"
endfun

" ===
" === clear spaces
" ===
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
