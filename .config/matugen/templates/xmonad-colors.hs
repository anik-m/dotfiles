
module Colors.Wallpaper where

import XMonad

colorScheme :: String
colorScheme = "wallpaper"

colorBack :: String
colorBack = "{{ colors.background.default.hex }}"

colorFore :: String
colorFore = "{{ colors.on_background.default.hex }}"

color01 :: String
color01 = "{{ colors.surface_container_highest.default.hex }}"

color02 :: String
color02 = "{{ colors.error.default.hex }}"

color03 :: String
color03 = "{{ colors.tertiary.default.hex }}"

color04 :: String
color04 = "{{ colors.secondary.default.hex }}"

color05 :: String
color05 = "{{ colors.primary.default.hex }}"

color06 :: String
color06 = "{{ colors.secondary.default.hex }}"

color07 :: String
color07 = "{{ colors.tertiary.default.hex }}"

color08 :: String
color08 = "{{ colors.surface_container_high.default.hex }}"

color09 :: String
color09 = "{{ colors.outline.default.hex }}"

color10 :: String
color10 = "{{ colors.error.default.hex }}"

color11 :: String
color11 = "{{ colors.tertiary.default.hex }}"

color12 :: String
color12 = "{{ colors.secondary.default.hex }}"

color13 :: String
color13 = "{{ colors.primary.default.hex }}"

color14 :: String
color14 = "{{ colors.secondary.default.hex }}"

color15 :: String
color15 = "{{ colors.tertiary.default.hex }}"

color16 :: String
color16 = "{{ colors.on_background.default.hex }}"

colorTrayer :: String
colorTrayer = "--tint 0x{{ colors.background.default.hex_stripped }}"
