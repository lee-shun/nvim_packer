local global = require 'core.global'

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
