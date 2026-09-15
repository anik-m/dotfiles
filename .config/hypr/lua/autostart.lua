local M = {}

function M.setup()
	hl.on("hyprland.start", function()
		hl.exec_cmd("nm-applet")
		hl.exec_cmd("waybar -c ~/.config/waybar/config-hypr.jsonc")
		hl.exec_cmd("hyprpaper")
		hl.exec_cmd("sleep 0.5 && ~/.local/bin/setbgtheme-hypr")
		hl.exec_cmd("fcitx5")
	end)
end

return M
