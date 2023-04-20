require('orgmode').setup_ts_grammar()

require('orgmode').setup({
  org_agenda_files = {"/mnt/storage/08_Notes/Agenda*.org"},
  org_default_notes_file = "/mnt/storage/08_Notes/Agenda/!refile.org",
  mappings = {
    global = {
      org_agenda = 'gA',
      org_capture = 'gC'
    },
	org = {
		org_toggle_checkbox = '<Leader><Space>'
	}
  }
})
