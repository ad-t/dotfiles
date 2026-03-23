return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/code/orgfiles/**/*',
      org_default_notes_file = '~/code/orgfiles/refile.org',
      org_startup_indented = true,
      org_startup_folded = 'showeverything',
      org_todo_keywords = {'TODO(t)', 'BLOCKED(b)', 'IN PROGRESS(p)', '|', 'DONE(d)', 'CANCELLED(c)'},
      org_blank_before_new_entry = { heading = false, plain_list_item = false },
      mappings = {
        org_return_uses_meta_return = true,
      }
    })
  end,
}
