local M = {}

function M.setup()
	hl.bind(
		"xf86audioraisevolume",
		hl.dsp.exec_cmd("wpctl set-volume -l 1 @default_audio_sink@ 5%+"),
		{ repeating = true }
	)

	hl.bind("xf86audiolowervolume", hl.dsp.exec_cmd("wpctl set-volume @default_audio_sink@ 5%-"), { repeating = true })

	hl.bind("xf86audiomute", hl.dsp.exec_cmd("wpctl set-mute @default_audio_sink@ toggle"), { locked = true })

	hl.bind("xf86audiomicmute", hl.dsp.exec_cmd("wpctl set-mute @default_audio_source@ toggle"), { locked = true })

	hl.bind("xf86monbrightnessup", hl.dsp.exec_cmd("brightnessctl s 10%+"), { repeating = true })

	hl.bind("xf86monbrightnessdown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { repeating = true })

	hl.bind("xf86audionext", hl.dsp.exec_cmd("playerctl next"))

	hl.bind("xf86audiopause", hl.dsp.exec_cmd("playerctl play-pause"))

	hl.bind("xf86audioplay", hl.dsp.exec_cmd("playerctl play-pause"))

	hl.bind("xf86audioprev", hl.dsp.exec_cmd("playerctl previous"))
end

return M
