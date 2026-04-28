-- Read current theme config
local function get_theme()
    local theme_file = vim.fn.expand("~/.local/share/nvim/theme.lua")
    if vim.fn.filereadable(theme_file) == 1 then
        local ok, t = pcall(dofile, theme_file)
        if ok and t then return t end
    end
    return {
        plugin      = "catppuccin/nvim",
        colorscheme = "catppuccin-mocha",
        setup       = function() require("catppuccin").setup({ flavour = "mocha" }) end,
    }
end

local theme = get_theme()

require("lazy").setup({

    -- ── Theme ──────────────────────────────────────────────────────────────
    {
        "catppuccin/nvim",
        name     = "catppuccin",
        priority = 1000,
        config   = function()
            require("catppuccin").setup({ flavour = "mocha" })
        end,
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config   = function()
            require("tokyonight").setup({ style = "night" })
        end,
    },

    -- ── Status line ────────────────────────────────────────────────────────
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme                = theme.colorscheme or "catppuccin-mocha",
                component_separators = { left = "", right = "" },
                section_separators   = { left = "", right = "" },
                globalstatus         = true,
            },
        },
    },

    -- ── File tree ──────────────────────────────────────────────────────────
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            default_file_explorer = true,
            view_options = { show_hidden = true },
        },
        keys = { { "-", "<cmd>Oil<CR>", desc = "Open parent directory" } },
    },

    -- ── Fuzzy finder ───────────────────────────────────────────────────────
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>",  desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>",   desc = "Live grep"  },
            { "<leader>fb", "<cmd>Telescope buffers<CR>",     desc = "Buffers"    },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>",   desc = "Help"       },
        },
    },

    -- ── Git ────────────────────────────────────────────────────────────────
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },

    -- ── Syntax ─────────────────────────────────────────────────────────────
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts  = {
            ensure_installed = { "lua", "vim", "bash", "python", "javascript",
                                 "typescript", "json", "yaml", "toml", "markdown" },
            highlight = { enable = true },
            indent    = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

}, {
    ui = { border = "rounded" },
})

-- Apply the active theme
if theme.setup then theme.setup() end
if theme.colorscheme then
    vim.cmd.colorscheme(theme.colorscheme)
end
