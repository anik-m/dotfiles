local M = {}

function M.setup()
	hl.env("XCURSOR_SIZE", "24")
	hl.env("HYPRCURSOR_SIZE", "24")
	hl.env("XDG_SESSION_TYPE", "wayland")
end

return M
