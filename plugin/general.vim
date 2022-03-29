augroup format_options
    autocmd!
    autocmd BufEnter * setlocal formatoptions+=m formatoptions+=B formatoptions-=o
augroup END

augroup restore_pos
    autocmd!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

augroup file_types
    autocmd!
    autocmd BufNewFile,BufRead *.launch set filetype=xml
    autocmd BufNewFile,BufRead *.Md set filetype=markdown
    autocmd BufNewFile,BufRead *.ejs set filetype=html
augroup END

if exists('##CmdLineEnter')
    augroup dynamic_smartcase
        autocmd!
        autocmd CmdLineEnter : set nosmartcase
        autocmd CmdLineLeave : set smartcase
    augroup END
endif

augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

augroup non_utf8_file_warn
    autocmd!
    autocmd BufRead * if &fileencoding != 'utf-8' && expand('%:e') != 'gz'
                \ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END

augroup number_toggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set norelativenumber | endif
augroup END

if exists('##TermOpen')
    let g:neoterm_autoscroll = 1
    augroup term_settings
        autocmd!
        autocmd TermOpen * setlocal norelativenumber nonumber
        autocmd TermOpen * startinsert
    augroup END

endif
