return {
    plugin = "catppuccin/nvim",
    colorscheme = "catppuccin-mocha",
    setup = function()
        require("catppuccin").setup({ flavour = "mocha" })
    end,
}
