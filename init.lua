--
-- basic
--
require('core')

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
vim.opt.dictionary:append('~/.config/nvim/20k')
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})




require('plugins')
