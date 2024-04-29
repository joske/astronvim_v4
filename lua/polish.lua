-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.cmd [[nnoremap <expr> <silent> 0 col('.') == match(getline('.'),'\\S')+1 ? '0' : '^']]
-- configure the litee.nvim library
require("litee.lib").setup {}
-- configure litee-calltree.nvim
require("litee.calltree").setup {}
-- local lspconfig = require "lspconfig"
-- local configs = require "lspconfig.configs"

-- if not configs.rustowl then
--   configs.rustowl = {
--     default_config = {
--       cmd = { "cargo", "owlsp" },
--       root_dir = lspconfig.util.root_pattern ".git",
--       filetypes = { "rust" },
--     },
--     idle_time = 2000,
--   }
-- end
-- lspconfig.rustowl.setup {}
