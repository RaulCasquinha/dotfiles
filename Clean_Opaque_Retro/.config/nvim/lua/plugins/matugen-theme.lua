return {
  {
    -- No external plugin needed — loads the file matugen generates
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local ok, theme = pcall(require, "colors.matugen")
        if ok then
          theme.apply()
        else
          vim.notify("matugen theme not found — run: matugen image <wallpaper>", vim.log.levels.WARN)
        end
      end,
    },
  },
}
