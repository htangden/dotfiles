#!/usr/bin/env python3

import argparse
import subprocess
import re

def get_battery_info():
    bat_path = "/org/freedesktop/UPower/devices/battery_BAT0"
    try:
        output = subprocess.check_output(["upower", "-i", bat_path], universal_newlines=True)
    except subprocess.CalledProcessError:
        return None, None

    # Extract percentage
    percentage_match = re.search(r"percentage:\s+(\d+)%", output)
    percentage = int(percentage_match.group(1)) if percentage_match else None

    # Extract time to empty
    time_match = re.search(r"time to empty:\s+([^\n]+)", output)

    if (time_match):
        time_to_empty = time_match.group(1).strip()
    else:
        time_to_full_match = re.search(r"time to full:\s+([^\n]+)", output)
        time_to_empty = time_to_full_match.group(1).strip() if time_to_full_match else "--"

    return percentage, time_to_empty


def main():
    parser = argparse.ArgumentParser(description="Display battery status with color formatting.")
    parser.add_argument("--label", type=str, default="#458588", help="Color for label text")
    parser.add_argument("--value", type=str, default="#ebdbb2", help="Color for value text")
    parser.add_argument("--low_battery_bg", type=str, default="#cc241d", help="Background color for low battery")
    args = parser.parse_args()

    percentage, time_to_empty = get_battery_info()

    if percentage is None:
        print(f'<span foreground="{args.label}" weight="bold">BAT:</span> <span foreground="{args.value}">N/A</span>')
        return

    if percentage < 20:
        print(
            f'<span weight="bold" foreground="{args.value}" background="{args.low_battery_bg}"> '
            f'BAT: {percentage}% {time_to_empty} </span>'
        )
    else:
        print(
            f'<span foreground="{args.label}" weight="bold">BAT:</span> '
            f'<span foreground="{args.value}">[{percentage}% {time_to_empty}]</span>'
        )


if __name__ == "__main__":
    main()

