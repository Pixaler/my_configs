local wezterm = require("wezterm")
local mux = wezterm.mux
-- Launch maximized
wezterm.on("gui-startup", function()
	local project_dir = "D:\\07_Projects"
	local tab, pane, window = mux.spawn_window({
		workspace = "coding",
		cwd = project_dir,
	})
	window:gui_window():maximize()
end)

return {
	default_prog = { "pwsh.exe" },
	font = wezterm.font("CaskaydiaCove NFM"),
	color_scheme = "Gruvbox dark, hard (base16)",
	keys = {
		{
			key = "PageUp",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}
