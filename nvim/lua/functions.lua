local M = {}

M.lsp_progress = function()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients <= 0 then
    -- no clients are attached, so report that
    return [[ no LSP ]]
  end
  local client_names = {}
  for _, client in pairs(clients) do
    table.insert(client_names, client.name)
  end
  return table.concat(client_names, ' | ')
end

return M
