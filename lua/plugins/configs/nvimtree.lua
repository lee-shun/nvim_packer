-- Mappings for nvimtree
vim.api.nvim_set_keymap(
  "n",
  "<leader>t",
  ":NvimTreeToggle<CR>",
  {
    noremap = true,
    silent = true
  }
)

require('nvim-tree').setup {
  view = {
    width = 30,
    height = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        { key = {"<CR>", "o", "l", "<2-LeftMouse>"}, action = "edit" },
        { key = "<C-e>",                        action = "edit_in_place" },
        { key = {"O"},                          action = "edit_no_picker" },
        { key = {"<CR>", "<C-]>"},    action = "cd" },
        { key = "<C-v>",                        action = "vsplit" },
        { key = "<C-x>",                        action = "split" },
        { key = "<C-t>",                        action = "tabnew" },
        { key = "<",                            action = "prev_sibling" },
        { key = ">",                            action = "next_sibling" },
        { key = "P",                            action = "parent_node" },
        { key = "h",                         action = "close_node" },
        { key = "<Tab>",                        action = "preview" },
        { key = "K",                            action = "first_sibling" },
        { key = "J",                            action = "last_sibling" },
        { key = "I",                            action = "toggle_git_ignored" },
        { key = "H",                            action = "toggle_dotfiles" },
        { key = "R",                            action = "refresh" },
        { key = "a",                            action = "create" },
        { key = "d",                            action = "remove" },
        { key = "D",                            action = "trash" },
        { key = "r",                            action = "rename" },
        { key = "<C-r>",                        action = "full_rename" },
        { key = "x",                            action = "cut" },
        { key = "c",                            action = "copy" },
        { key = "p",                            action = "paste" },
        { key = "y",                            action = "copy_name" },
        { key = "Y",                            action = "copy_path" },
        { key = "gy",                           action = "copy_absolute_path" },
        { key = "[c",                           action = "prev_git_item" },
        { key = "]c",                           action = "next_git_item" },
        { key = "<BS>",                            action = "dir_up" },
        { key = "s",                            action = "system_open" },
        { key = "q",                            action = "close" },
        { key = "g?",                           action = "toggle_help" },
        { key = "W",                            action = "collapse_all" },
        { key = "S",                            action = "search_node" },
        { key = "K",                        action = "toggle_file_info" },
        { key = ".",                            action = "run_file_command" }
      },
    },
  }
}
