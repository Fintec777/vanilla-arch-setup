return {
    plugin = "folke/tokyonight.nvim",
    colorscheme = "tokyonight-night",
    setup = function()
        require("tokyonight").setup({ style = "night" })
    end,
}
