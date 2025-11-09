#!/usr/bin/env bash

# --- Waybar Battery Poll Script (Energy-Based) ---

# --- CONFIGURATION ---
BATTERIES=("BAT0" "BAT1")
# --- END CONFIGURATION ---

# --- Absolute Paths for Commands ---
AWK="/usr/bin/awk"
CAT="/usr/bin/cat"

# --- Associative Array Declaration ---
declare -A battery_data

# --- Data Reading and Total Calculation ---
total_energy_now=0
total_energy_full=0
total_power_now=0
overall_status="Discharging"
has_charging=false
all_full=true

for bat in "${BATTERIES[@]}"; do
    if [[ -d "/sys/class/power_supply/$bat" ]]; then
        battery_data["$bat-exists"]=true
        bat_energy_now_raw=$($CAT "/sys/class/power_supply/$bat/energy_now" 2>/dev/null)
        bat_energy_now=${bat_energy_now_raw:-0}
        bat_energy_full_raw=$($CAT "/sys/class/power_supply/$bat/energy_full" 2>/dev/null)
        bat_energy_full=${bat_energy_full_raw:-0}
        bat_power_now_raw=$($CAT "/sys/class/power_supply/$bat/power_now" 2>/dev/null)
        bat_power_now=${bat_power_now_raw:-0}
        bat_stat_raw=$($CAT "/sys/class/power_supply/$bat/status" 2>/dev/null)
        bat_stat=${bat_stat_raw:-"Unknown"}

        total_energy_now=$((total_energy_now + bat_energy_now))
        total_energy_full=$((total_energy_full + bat_energy_full))
        
        if [[ "$bat_stat" == "Discharging" ]]; then
            total_power_now=$((total_power_now + bat_power_now))
        fi

        if (( bat_energy_full > 0 )); then
            battery_data["$bat-cap"]=$((bat_energy_now * 100 / bat_energy_full))
        else
            battery_data["$bat-cap"]=0
        fi
        
        battery_data["$bat-stat"]=$bat_stat

        if [[ "$bat_stat" == "Charging" ]]; then
            has_charging=true
        fi
        if [[ "$bat_stat" != "Full" ]]; then
            all_full=false
        fi
    else
        battery_data["$bat-exists"]=false
    fi
done

# --- Determine Overall Status ---
if $has_charging; then
    overall_status="Charging"
elif $all_full; then
    overall_status="Full"
else
    overall_status="Discharging"
fi

# --- Overall Percentage Calculation ---
if (( total_energy_full > 0 )); then
    overall_pct=$((total_energy_now * 100 / total_energy_full))
else
    overall_pct=0
fi

# --- Build Output Strings ---
# 1. Main Text (Default View)
if [[ "$overall_status" == "Full" ]]; then
    text_output="Full"
else
    text_output="${overall_pct}%"
fi

# 2. Tooltip (Hover View) - Using Pango Markup
# Use literal newlines (\n) here. We will escape them later.
has_any_battery=false
individual_bat_tooltips=""
for bat in "${BATTERIES[@]}"; do
    if ${battery_data["$bat-exists"]}; then
        has_any_battery=true
        bat_pct=${battery_data["$bat-cap"]}
        bat_stat=${battery_data["$bat-stat"]}
        
        if [[ -n "$individual_bat_tooltips" ]]; then
             individual_bat_tooltips+="\n"
        fi
        
        individual_bat_tooltips+="<b>${bat}:</b> ${bat_pct}% <i>(${bat_stat})</i>"
    fi
done

if $has_any_battery; then
    tooltip_output="<big><b>Batteries</b></big>\n${individual_bat_tooltips}"
else
    tooltip_output="No batteries found."
fi

# --- Final JSON Output (using printf) ---

# --- JSON Escaping ---
# THIS IS THE PART THAT FIXES YOUR PROBLEM.
# 1. Escape any backslashes (this must be first)
# tooltip_output_escaped=${tooltip_output//\\/\\\\}
# # 2. Escape any double-quotes
# tooltip_output_escaped=${tooltip_output_escaped//\"/\\\"}
# # 3. Replace all literal newlines ($'\n') with the string '\\n'
# tooltip_output_escaped=${tooltip_output_escaped//$'\n'/\\n}

# --- Final Printf ---
# We only output text and tooltip
printf '{"text": "%s", "alt": "%s"}\n' \
    "$text_output" \
    "$tooltip_output"
