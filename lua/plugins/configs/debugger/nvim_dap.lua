local dap = require('dap')

--
-- cpp
--

-- adapter
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/ls/.language_tools/cpptools-linux/extension/debugAdapters/bin/OpenDebugAD7',
}

-- gdb
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
  }
}

--
-- c
--
dap.configurations.c = dap.configurations.cpp


--
-- python
--

