-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command

        -- mine
        ["<leader>m"] = { name = "󱁤 Compiler" },
        ["<leader>mt"] = { "<cmd>TexlabBuild<cr>", desc = "LaTeX" },
        ["<leader>mc"] = { name = "Cargo" },
        ["<leader>mcb"] = { "<cmd>terminal cargo build<cr>", desc = "Cargo Build" },
        ["<leader>mcr"] = { "<cmd>terminal cargo run<cr>", desc = "Cargo Run" },
        ["<leader>lc"] = { name = "Calls" },
        ["<leader>lci"] = { function() vim.lsp.buf.incoming_calls() end, desc = "Incoming Calls" },
        ["<leader>lco"] = { function() vim.lsp.buf.outgoing_calls() end, desc = "Outgoing Calls" },
        ["<leader>lcc"] = { function() require("litee.calltree").close_calltree() end, desc = "Close Calltree" },
        ["<leader>lcp"] = { function() require("litee.calltree").popout_to() end, desc = "Popout Calltree" },

        -- Rust
        ["<leader>r"] = { name = " Rust Tools" },
        ["<leader>rm"] = { function() vim.cmd.RustLsp "expandMacro" end, desc = "Expand Macro" },
        ["<leader>rC"] = { function() vim.cmd.RustLsp "openCargo" end, desc = "Open Cargo.toml" },
        ["<leader>rD"] = { function() vim.cmd.RustLsp "openDocs" end, desc = "Open Docs" },
        ["<leader>rp"] = { function() vim.cmd.RustLsp "parentModule" end, desc = "Parent Module" },
        ["<leader>rb"] = { function() vim.cmd.RustLsp "runnables" end, desc = "Rust Runnables" },
        ["<leader>rd"] = { function() vim.cmd.RustLsp "debuggables" end, desc = "Rust Debuggables" },
        ["<leader>rt"] = { function() vim.cmd.RustLsp "testables" end, desc = "Rust Testables" },
        ["<leader>rf"] = { function() vim.cmd.RustLsp "workspaceSymbol" end, desc = "Find Symbol" },
        ["<leader>rj"] = { function() vim.cmd.RustLsp "joinLines" end, desc = "Join Lines" },
        ["<leader>re"] = { function() vim.cmd.RustLsp "explainError" end, desc = "Explain Error" },
        -- Crates
        ["<leader>rc"] = { name = "Crates" },
        ["<leader>rcr"] = { function() require("crates").reload() end, desc = "Reload Crates" },
        ["<leader>rcf"] = { function() require("crates").show_features_popup() end, desc = "Show Features" },
        ["<leader>rcv"] = { function() require("crates").show_versions_popup() end, desc = "Show Versions" },
        ["<leader>rcd"] = { function() require("crates").show_dependencies_popup() end, desc = "Show Dependencies" },
        ["<leader>rcu"] = { function() require("crates").update() end, desc = "Update Crate" },
        ["<leader>rca"] = { function() require("crates").update_all_crates() end, desc = "Update All Crates" },
        ["<leader>rcU"] = { function() require("crates").upgrade_crate() end, desc = "Upgrade Crate" },
        ["<leader>rcA"] = { function() require("crates").upgrade_all_crates() end, desc = "Upgrade All Crates" },
        ["<leader>rcH"] = { function() require("crates").open_homepage() end, desc = "Open Homepage" },
        ["<leader>rcR"] = { function() require("crates").open_repository() end, desc = "Open Repository" },
        ["<leader>rcD"] = { function() require("crates").open_documentation() end, desc = "Open Documentation" },
        ["<leader>rcC"] = { function() require("crates").open_crates_io() end, desc = "Open crates.io" },
        -- Trouble
        ["<leader>x"] = { name = "Trouble" },
        ["<leader>xx"] = { "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble" },
        ["<leader>xd"] = {
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Trouble Document",
        },
        ["<leader>xl"] = { "<cmd>Trouble loclist toggle<cr>", desc = "Trouble Location List" },
        ["<leader>xq"] = { "<cmd>Trouble qflist toggle<cr>", desc = "Trouble Quickfix" },
        ["<leader>xr"] = {
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "Trouble LSP References",
        },
        -- Git
        ["<leader>g"] = { name = "Git" },
        ["<leader>gs"] = { "<cmd>Git<cr>", desc = "Git Status" },
        ["<leader>gv"] = { "<cmd>Git blame<cr>", desc = "Git Blame" },
        ["<leader>gB"] = { "<cmd>ToggleBlameLine<CR>", desc = "Git Blame Line" },
        ["<leader>gd"] = { "<cmd>DiffviewOpen<cr>", desc = "Git Diff" },
        ["<leader>gD"] = { "<cmd>DiffviewClose<cr>", desc = "Git Diff Close" },
        ["<leader>gR"] = { "<cmd>DiffviewRefresh<cr>", desc = "Git Diff Refresh" },
        ["<leader>gf"] = { "<cmd>DiffviewFileHistory<cr>", desc = "Git Diff File Hystory" },
        ["<leader>gF"] = { "<cmd>DiffviewToggleFiles<cr>", desc = "Git Diff Toggle Files" },
        ["<leader>gC"] = { "<cmd>DiffviewToggleCache<cr>", desc = "Git Diff Toggle Cache" },
        ["<leader>gS"] = { "<cmd>DiffviewToggleSigns<cr>", desc = "Git Diff Toggle Signs" },
        ["<leader>gT"] = { "<cmd>DiffviewToggle<cr>", desc = "Git Diff Toggle" },
        ["<leader>gm"] = { "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },

        -- Todo
        ["<leader>T"] = { name = "TODOs" },
        ["<leader>Tt"] = { "<cmd>TodoTelescope<cr>", desc = "Open TODOs in Telescope" },
        ["<leader>Tq"] = { "<cmd>TodoQuickFix<cr>", desc = "Open TODOs in QuickFix" },
        ["<leader>Tx"] = { "<cmd>TodoTrouble<cr>", desc = "Open TODOs in Trouble" },
        -- Telescope
        ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Go to References" },
        ["gs"] = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
        ["<C-M-h>"] = { "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Call Hierarchy" },
      },
      i = {
        ["<c-s>"] = { "<esc>:w<cr>", desc = "Save File" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
