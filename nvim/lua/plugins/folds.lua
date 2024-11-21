local function fold_virt_text_handler(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󱞢 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth) end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

return {
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            { "kevinhwang91/promise-async" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("ufo").setup({
                provider_selector = function(_, _, _) return { "treesitter", "indent" } end,
            })

            -- Folds
            vim.o.foldcolumn = "1"
            vim.o.foldlevel = 99
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        end,
        keys = function()
            local ufo = require("ufo")
            return {
                { "zR", ufo.openAllFolds, desc = "Open all folds" },
                { "zM", ufo.closeAllFolds, desc = "Close all folds" },
                { "zr", ufo.openFoldsExceptKinds, desc = "Open folds except kinds" },
                { "zm", ufo.closeFoldsWith, desc = "Close folds with" },
            }
        end,
    },
}
