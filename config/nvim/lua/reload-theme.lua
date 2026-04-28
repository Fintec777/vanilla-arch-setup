-- Called by set-theme to hot-reload the colourscheme in running nvim instances
local theme_file = vim.fn.expand("~/.local/share/nvim/theme.lua")
if vim.fn.filereadable(theme_file) == 1 then
    local ok, t = pcall(dofile, theme_file)
    if ok and t then
        if t.setup then t.setup() end
        if t.colorscheme then
            vim.cmd.colorscheme(t.colorscheme)
            -- Update lualine theme too
            local ok2, ll = pcall(require, "lualine")
            if ok2 then
                ll.setup({ options = { theme = t.colorscheme } })
            end
        end
    end
end
