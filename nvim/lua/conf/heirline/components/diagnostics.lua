local conditions = require("heirline.conditions")

return {
  condition = conditions.has_diagnostics,

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })

    self.error_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.ERROR]
    self.warn_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.WARN]
    self.info_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.INFO]
    self.hint_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.HINT]
  end,

  update = { "DiagnosticChanged" },

  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "red" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "orange" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "green" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "purple" },
  },
}
