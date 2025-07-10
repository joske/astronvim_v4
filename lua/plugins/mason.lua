-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-tool-installer for automatically installing Mason packages
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- overrides `require("mason-tool-installer").setup(...)`
    opts = {
      -- Make sure to use the names found in `:Mason`
      ensure_installed = {
        -- install language servers
        "lua-language-server",
        "texlab",

        -- install formatters
        "stylua",
        "biome",
        "prettier",
        "stylua",
        "clang-format",
        "rubocop",
        "shfmt",
        "yamlfmt",
        "xmlformatter",
        "shellcheck",
        "latexindent",

        -- install debuggers
        "debugpy",
        "codelldb",

        -- install any other package
        "tree-sitter-cli",
      },
    },
  },
}
