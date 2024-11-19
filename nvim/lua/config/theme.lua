if os.getenv("NVIM_THEME") ~= nil then
    vim.cmd("colorscheme " .. os.getenv("NVIM_THEME"))
elseif os.getenv("THEME") ~= nil then
    vim.cmd("colorscheme " .. os.getenv("THEME"))
else
    vim.cmd("colorscheme onedark")
end
