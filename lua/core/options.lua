local global = require('core.global')

-- Create cache dir and subs dir
local createdir = function ()
  local data_dir = {
    global.tmp_dir..'backup',
    global.tmp_dir..'session',
    global.tmp_dir..'swap',
    global.tmp_dir..'tags',
    global.tmp_dir..'undo'
  }
  -- There only check once that If cache_dir exists
  -- Then I don't want to check subs dir exists
  if vim.fn.isdirectory(global.tmp_dir) == 0 then
    os.execute("mkdir -p " .. global.tmp_dir)
    print("mkdir nvim tmp dir!")
    for _,v in pairs(data_dir) do
      if vim.fn.isdirectory(v) == 0 then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

createdir()
--
-- options
--
vim.o.encoding='utf-8'
vim.o.fileencodings = 'ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1'
vim.o.termencoding='utf-8'
vim.o.fileformats='unix,dos,mac'

vim.cmd([[
augroup Format-Options
autocmd!
autocmd BufEnter * setlocal formatoptions+=m formatoptions+=B formatoptions-=o
augroup END
]])

vim.cmd('filetype plugin indent on')
vim.o.compatible=false
vim.g.mapleader = ' '
vim.o.autochdir = true
vim.o.autoread=true

vim.cmd('syntax on')
vim.o.scrolloff=5
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorcolumn=true
vim.o.colorcolumn='81,121'
vim.o.textwidth=80
vim.o.hidden=true
vim.o.showmode=true
vim.o.showcmd=true
vim.o.mouse=''
vim.o.wrap=false
vim.o.linebreak=true
vim.o.timeout=true
vim.o.timeoutlen=1000
vim.o.ttimeout=true
vim.o.ttimeoutlen=10
vim.o.conceallevel=0
vim.o.wildmenu=true
vim.o.lazyredraw=true
vim.o.ttyfast=true
vim.o.t_Co=256
vim.o.termguicolors=true
vim.o.laststatus=2
vim.o.cmdheight=1
vim.o.spelllang='en,cjk'
vim.o.spellfile='~/.config/nvim/spell/en.utf-8.add'
vim.o.spellfile=global.vim_config_path..'spell/en.utf-8.add'
vim.o.shiftround=true
vim.o.virtualedit='block'

vim.o.inccommand='split'

vim.o.showmatch=true
vim.opt.iskeyword:append('_,$,@,%,#,-')
vim.o.matchpairs='(:),{:},[:],<:>'
vim.o.whichwrap='b,s,<,>,[,]'

vim.o.hlsearch=true
vim.o.incsearch=true
vim.o.ignorecase=true
vim.o.smartcase=true
vim.cmd('nohlsearch')

vim.o.smartindent=true
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.smarttab=true
vim.o.expandtab=true
vim.o.shiftround=true

vim.o.foldmethod='manual'
vim.o.foldlevel=99
vim.o.foldenable=true

vim.o.list=true
vim.o.listchars='tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
vim.o.showbreak='↪'

vim.opt.clipboard:prepend('unnamed,unnamedplus')

vim.o.completeopt='menuone,noselect,noinsert'
vim.opt.complete:append('k')

vim.cmd([[
augroup Restore-Pos
autocmd!
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
]])

vim.o.undofile = true
vim.o.swapfile = true
vim.o.backup = false
vim.o.undodir=global.vim_config_path..'tmp/undo'
vim.o.backupdir=global.vim_config_path..'tmp/backup'
vim.o.directory=global.vim_config_path..'tmp/backup'

vim.opt.wildignore:append('*.o,*.obj,*.bin,*.dll,*.exe')
vim.opt.wildignore:append('*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**')
vim.opt.wildignore:append('*.pyc')
vim.opt.wildignore:append('*.DS_Store')
vim.opt.wildignore:append('*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf')

vim.cmd([[
autocmd BufNewFile,BufRead *.launch set filetype=xml
autocmd BufNewFile,BufRead *.Md set filetype=markdown
autocmd BufNewFile,BufRead *.ejs set filetype=html
]])

vim.g.netrw_preview	=1
vim.g.netrw_hide = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 30
vim.g.netrw_altv = 1
vim.g.netrw_chgwin = 2
vim.g.netrw_list_hide = '.*\\.swp$'
vim.g.netrw_localrmdir = 'rm -rf'

if vim.fn.exists('##CmdLineEnter') then
  vim.cmd([[
        augroup dynamic_smartcase
            autocmd!
            autocmd CmdLineEnter : set nosmartcase
            autocmd CmdLineLeave : set smartcase
        augroup END
    ]])
end

vim.cmd([[
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END
]])

vim.cmd([[
augroup non_utf8_file_warn
    autocmd!
    autocmd BufRead * if &fileencoding != 'utf-8' && expand('%:e') != 'gz'
                \ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END
]])

vim.cmd([[
augroup number_toggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set norelativenumber | endif
augroup END
]])

vim.g.neoterm_autoscroll = 1
if vim.fn.exists('##TermOpen') then
  vim.cmd([[
        augroup term_settings
        autocmd!
        autocmd TermOpen * setlocal norelativenumber nonumber
        autocmd TermOpen * startinsert
    augroup END

]])
end
