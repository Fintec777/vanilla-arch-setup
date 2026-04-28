return {
    plugin = "catppuccin/nvim",
    colorscheme = "catppuccin-latte",
    setup = function()
        require("catppuccin").setup({ flavour = "latte" })
    end,
}
