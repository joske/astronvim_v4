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
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
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
        ["<Leader>m"] = { desc = "󱁤 Compiler" },
        ["<Leader>mt"] = { "<cmd>TexlabBuild<cr>", desc = "LaTeX" },
        ["<Leader>mc"] = { desc = "Cargo" },
        ["<Leader>mcb"] = { "<cmd>terminal cargo build<cr>", desc = "Cargo Build" },
        ["<Leader>mcr"] = { "<cmd>terminal cargo run<cr>", desc = "Cargo Run" },
        ["<Leader>lc"] = { desc = "Calls" },
        ["<Leader>lci"] = { function() vim.lsp.buf.incoming_calls() end, desc = "Incoming Calls" },
        ["<Leader>lco"] = { function() vim.lsp.buf.outgoing_calls() end, desc = "Outgoing Calls" },
        ["<Leader>lcc"] = { function() require("litee.calltree").close_calltree() end, desc = "Close Calltree" },
        ["<Leader>lcp"] = { function() require("litee.calltree").popout_to() end, desc = "Popout Calltree" },

        -- Rust
        ["<Leader>r"] = { desc = " Rust Tools" },
        ["<Leader>ra"] = { function() vim.cmd.RustLsp "codeAction" end, desc = "Rust Code Action" },
        ["<Leader>rm"] = { function() vim.cmd.RustLsp "expandMacro" end, desc = "Expand Macro" },
        ["<Leader>rC"] = { function() vim.cmd.RustLsp "openCargo" end, desc = "Open Cargo.toml" },
        ["<Leader>rD"] = { function() vim.cmd.RustLsp "openDocs" end, desc = "Open Docs" },
        ["<Leader>rp"] = { function() vim.cmd.RustLsp "parentModule" end, desc = "Parent Module" },
        ["<Leader>rb"] = { function() vim.cmd.RustLsp "runnables" end, desc = "Rust Runnables" },
        ["<Leader>rd"] = { function() vim.cmd.RustLsp "debuggables" end, desc = "Rust Debuggables" },
        ["<Leader>rt"] = { function() vim.cmd.RustLsp "testables" end, desc = "Rust Testables" },
        ["<Leader>rf"] = { function() vim.cmd.RustLsp "workspaceSymbol" end, desc = "Find Symbol" },
        ["<Leader>rj"] = { function() vim.cmd.RustLsp "joinLines" end, desc = "Join Lines" },
        ["<Leader>re"] = { function() vim.cmd.RustLsp "explainError" end, desc = "Explain Error" },

        -- Crates
        ["<Leader>rc"] = { desc = "Crates" },
        ["<Leader>rcr"] = { function() require("crates").reload() end, desc = "Reload Crates" },
        ["<Leader>rcf"] = { function() require("crates").show_features_popup() end, desc = "Show Features" },
        ["<Leader>rcv"] = { function() require("crates").show_versions_popup() end, desc = "Show Versions" },
        ["<Leader>rcd"] = { function() require("crates").show_dependencies_popup() end, desc = "Show Dependencies" },
        ["<Leader>rcu"] = { function() require("crates").update() end, desc = "Update Crate" },
        ["<Leader>rca"] = { function() require("crates").update_all_crates() end, desc = "Update All Crates" },
        ["<Leader>rcU"] = { function() require("crates").upgrade_crate() end, desc = "Upgrade Crate" },
        ["<Leader>rcA"] = { function() require("crates").upgrade_all_crates() end, desc = "Upgrade All Crates" },
        ["<Leader>rcH"] = { function() require("crates").open_homepage() end, desc = "Open Homepage" },
        ["<Leader>rcR"] = { function() require("crates").open_repository() end, desc = "Open Repository" },
        ["<Leader>rcD"] = { function() require("crates").open_documentation() end, desc = "Open Documentation" },
        ["<Leader>rcC"] = { function() require("crates").open_crates_io() end, desc = "Open crates.io" },
        -- Trouble
        ["<Leader>x"] = { desc = "Trouble" },
        ["<Leader>xx"] = { "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble" },
        ["<Leader>xd"] = {
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Trouble Document",
        },
        ["<Leader>xl"] = { "<cmd>Trouble loclist toggle<cr>", desc = "Trouble Location List" },
        ["<Leader>xq"] = { "<cmd>Trouble qflist toggle<cr>", desc = "Trouble Quickfix" },
        ["<Leader>xr"] = {
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "Trouble LSP References",
        },
        -- Git
        ["<Leader>g"] = { desc = "Git" },
        ["<Leader>gs"] = { "<cmd>Git<cr>", desc = "Git Status" },
        ["<Leader>gv"] = { "<cmd>Git blame<cr>", desc = "Git Blame" },
        ["<Leader>gB"] = { "<cmd>ToggleBlameLine<CR>", desc = "Git Blame Line" },
        ["<Leader>gd"] = { "<cmd>DiffviewOpen<cr>", desc = "Git Diff" },
        ["<Leader>gD"] = { "<cmd>DiffviewClose<cr>", desc = "Git Diff Close" },
        ["<Leader>gR"] = { "<cmd>DiffviewRefresh<cr>", desc = "Git Diff Refresh" },
        ["<Leader>gf"] = { "<cmd>DiffviewFileHistory<cr>", desc = "Git Diff File Hystory" },
        ["<Leader>gF"] = { "<cmd>DiffviewToggleFiles<cr>", desc = "Git Diff Toggle Files" },

        -- Markdown
        ["<Leader>gm"] = { "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },

        -- Todo
        ["<Leader>T"] = { desc = "TODOs" },
        ["<Leader>Tt"] = { "<cmd>TodoTelescope<cr>", desc = "Open TODOs in Telescope" },
        ["<Leader>Tq"] = { "<cmd>TodoQuickFix<cr>", desc = "Open TODOs in QuickFix" },
        ["<Leader>Tx"] = { "<cmd>TodoTrouble<cr>", desc = "Open TODOs in Trouble" },
        -- Telescope
        ["<Leader>fG"] = { "<cmd>Telescope git_commits<cr>", desc = "Go to Git Commits" },
        ["gr"] = { "<cmd>Telescope lsp_references<cr>", desc = "Go to References" },
        ["gi"] = { "<cmd>Telescope lsp_implementations<cr>", desc = "Go to Implementations" },
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
