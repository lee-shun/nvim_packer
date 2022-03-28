-- install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- plugins
require('packer').startup( function(use)
    use { 'wbthomason/packer.nvim'}

    -- UI
    use {'arcticicestudio/nord-vim'}
    use { 'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {'kyazdani42/nvim-web-devicons', opt = true} }
    use {'Avimitin/nerd-galaxyline',
    requires = { 'Avimitin/neovim-deus'}}

    -- file navgative
    use { 'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function() require('plugins.configs.nvimtree') end }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

require('plugins.configs.color')
