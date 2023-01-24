return {
    "navarasu/onedark.nvim",
    lazy = false,
    config = function()
        require("onedark").setup({
            style = "darker",
            transparent = true,
        })
        require("onedark").load()
    end,
}
