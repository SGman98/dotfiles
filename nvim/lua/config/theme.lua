if os.getenv("THEME") ~= nil then
    vim.cmd("colorscheme " .. os.getenv("THEME"))
else
    vim.cmd("colorscheme onedark")
end
