#!/bin/bash

# Path to your battery device
BAT_PATH="/org/freedesktop/UPower/devices/battery_BAT0"

# Get battery percentage (number only)
percentage=$(upower -i "$BAT_PATH" | awk '/percentage:/ {print $2}' | sed 's/%//')

# Get time to empty (string like "6.8 hours" or "1.2 hours")
time_to_empty=$(upower -i "$BAT_PATH" | awk -F: '/time to empty/ {
    gsub(/^[ \t]+/, "", $2);
    print $2
}')

# If battery is charging, UPower sometimes reports "N/A". Handle that.
if [ -z "$time_to_empty" ]; then
    time_to_empty="--"
fi

# Check if percentage is under 20%
if [ "$percentage" -lt 20 ]; then
    # Red background for low battery
    printf '<span weight="bold" foreground="#ebdbb2" background="#cc241d"> BAT: %s%% %s </span>\n' "$percentage" "$time_to_empty"
else
    # Normal styling
    printf '<span foreground="#458588" weight="bold">BAT:</span> <span foreground="#ebdbb2">[%s%% %s]</span>\n' "$percentage" "$time_to_empty"
fi

