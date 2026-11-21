-- With permanent_delete = false, mini.files moves deletions to this trash and
-- never empties it. Drop entries trashed more than 30 days ago: moving a file
-- updates its ctime, so ctime records when it was trashed (mtime does not).
local trash_days = 30

local function empty_old_trash()
    local trash = vim.fn.stdpath("data") .. "/mini.files/trash"
    if vim.fn.isdirectory(trash) == 0 then return end
    -- Detached so a large delete keeps going after nvim exits
    -- stylua: ignore
    vim.system({
        "find", trash, "-mindepth", "1", "-maxdepth", "1", "-ctime", "+" .. trash_days,
        "-exec", "rm", "-rf", "--", "{}", "+",
    }, { detach = true })
end

return {
    {
        "echasnovski/mini.files",
        version = "*",
        opts = {
            mappings = {
                close = "<Esc>",
                go_in = "<right>",
                go_in_plus = "<CR>",
                go_out = "<left>",
                go_out_plus = "-",
            },
            options = {
                permanent_delete = false,
            },
            windows = {
                preview = true,
            },
        },
        lazy = false,
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                once = true,
                desc = "Empty old mini.files trash",
                callback = empty_old_trash,
            })
        end,
        keys = {
            { "-", "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", desc = "Open files" },
        },
    },
}
