#!/usr/bin/env bash

# ============================================================
# Waybar Battery Check
# Multiple battery / energy-weighted percentage
# ============================================================

BATTERIES=("BAT0" "BAT1")

CAT="/usr/bin/cat"

declare -A battery_exists
declare -A battery_capacity
declare -A battery_status

total_energy_now=0
total_energy_full=0
battery_count=0

has_battery=false
has_charging=false
all_full=true

# ============================================================
# READ BATTERIES
# ============================================================

for bat in "${BATTERIES[@]}"; do

    path="/sys/class/power_supply/$bat"

    if [[ ! -d "$path" ]]; then
        battery_exists["$bat"]=false
        continue
    fi

    battery_exists["$bat"]=true
    has_battery=true
    battery_count=$((battery_count + 1))

    # --------------------------------------------------------
    # Capacity
    # --------------------------------------------------------

    capacity=$("$CAT" "$path/capacity" 2>/dev/null)

    if ! [[ "$capacity" =~ ^[0-9]+$ ]]; then
        capacity=0
    fi

    battery_capacity["$bat"]="$capacity"

    # --------------------------------------------------------
    # Status
    # --------------------------------------------------------

    status=$("$CAT" "$path/status" 2>/dev/null)

    [[ -z "$status" ]] && status="Unknown"

    battery_status["$bat"]="$status"

    # --------------------------------------------------------
    # Energy
    # --------------------------------------------------------

    energy_now=$("$CAT" "$path/energy_now" 2>/dev/null)
    energy_full=$("$CAT" "$path/energy_full" 2>/dev/null)

    if [[ "$energy_now" =~ ^[0-9]+$ ]] &&
       [[ "$energy_full" =~ ^[0-9]+$ ]] &&
       (( energy_full > 0 )); then

        total_energy_now=$((total_energy_now + energy_now))
        total_energy_full=$((total_energy_full + energy_full))

    fi

    # --------------------------------------------------------
    # Charging state
    # --------------------------------------------------------

    if [[ "$status" == "Charging" ]]; then
        has_charging=true
    fi

    if [[ "$status" != "Full" ]]; then
        all_full=false
    fi

done

# ============================================================
# NO BATTERIES
# ============================================================

if [[ "$has_battery" == false ]]; then

    printf '%s\n' \
        '{"text":"N/A","alt":"No battery","tooltip":"No batteries found.","class":["critical"],"percentage":0}'

    exit 0

fi

# ============================================================
# CALCULATE OVERALL PERCENTAGE
# ============================================================

if (( total_energy_full > 0 )); then

    # Energy-weighted percentage
    overall_pct=$(( total_energy_now * 100 / total_energy_full ))

else

    # Fallback: average battery capacities
    total_capacity=0

    for bat in "${BATTERIES[@]}"; do

        if [[ "${battery_exists["$bat"]}" == true ]]; then
            total_capacity=$(
                ((
                    total_capacity +
                    battery_capacity["$bat"]
                ))
            )
        fi

    done

    if (( battery_count > 0 )); then
        overall_pct=$(( total_capacity / battery_count ))
    else
        overall_pct=0
    fi

fi

# ------------------------------------------------------------
# Safety
# ------------------------------------------------------------

if ! [[ "$overall_pct" =~ ^[0-9]+$ ]]; then
    overall_pct=0
fi

(( overall_pct < 0 )) && overall_pct=0
(( overall_pct > 100 )) && overall_pct=100

# ============================================================
# OVERALL STATUS
# ============================================================

if [[ "$has_charging" == true ]]; then

    overall_status="Charging"

elif [[ "$all_full" == true ]]; then

    overall_status="Full"

else

    overall_status="Discharging"

fi

# ============================================================
# CSS CLASS
# ============================================================

if [[ "$overall_status" == "Charging" ]]; then

    css_class="charging"

elif [[ "$overall_status" == "Full" ]]; then

    css_class="full"

elif (( overall_pct <= 15 )); then

    css_class="critical"

elif (( overall_pct <= 30 )); then

    css_class="warning"

else

    css_class="normal"

fi

# ============================================================
# TEXT
# ============================================================

if [[ "$overall_status" == "Full" ]]; then
    text_output="Full"
else
    text_output="${overall_pct}%"
fi

# ============================================================
# TOOLTIP
# ============================================================

tooltip_output="<big><b>Batteries</b></big>"

for bat in "${BATTERIES[@]}"; do

    if [[ "${battery_exists["$bat"]}" == true ]]; then

        pct="${battery_capacity["$bat"]}"
        status="${battery_status["$bat"]}"

        tooltip_output+="\r<b>${bat}:</b> ${pct}% <i>(${status})</i>"

    fi

done

# ============================================================
# JSON
# ============================================================

printf \
    '{"text":"%s","alt":"%s","tooltip":"%s","class":["%s"],"percentage":%s}\n' \
    "$text_output" \
    "$overall_status" \
    "$tooltip_output" \
    "$css_class" \
    "$overall_pct"
