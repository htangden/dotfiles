#!/bin/bash

# Get battery percentage
percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage:/ {print $2}' | sed 's/%//')

# Check if percentage is under 20%
if [ "$percentage" -lt 20 ]; then
    # Red background for low battery
    printf '<span weight="bold" foreground="#ebdbb2" background="#cc241d"> BAT: %s%% </span>\n' "$percentage" 
else
    # Normal styling
    printf '<span foreground="#458588" weight="bold">BAT:</span> <span foreground="#ebdbb2">%s%%</span>\n' "$percentage"
fi
