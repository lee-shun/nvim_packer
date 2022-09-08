require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
  rainbow = {
    enable = true,
  },
  ensure_installed = {'org', 'markdown', 'cpp', 'c', 'python'}
}
