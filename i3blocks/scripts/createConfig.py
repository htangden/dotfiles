#!/usr/bin/env python3

# i3blocks config generator

CONFIG_FILE = "/home/hugo/.config/i3blocks/config"


import argparse

parser = argparse.ArgumentParser(description="Generate i3blocks config with custom colors.")
parser.add_argument("--label", type=str, default="#458588", help="Color for labels")
parser.add_argument("--value", type=str, default="#ebdbb2", help="Color for values")
parser.add_argument("--low_battery_bg", type=str, default="#cc241d", help="Background color for low battery")
args = parser.parse_args()

colors = {
    "label": args.label,
    "value": args.value,
    "low_battery_bg": args.low_battery_bg
}

blocks = [
    {
        "name": "time",
        "command": "date '+<span foreground=\"{label}\" weight=\"bold\">Time:</span> <span foreground=\"{value}\">%H:%M</span>'",
        "interval": 5
    },
    {
        "name": "memory",
        "command": "free -h | awk '/^Mem/ {{printf \"<span foreground=\\\"{label}\\\" weight=\\\"bold\\\">RAM:</span> <span foreground=\\\"{value}\\\">%s / %s</span>\\n\", $3, $2}}'",
        "interval": 10
    },
    {
        "name": "volume",
        "command": "amixer get Master | awk -F'[][]' '/Left:/ {{printf \"<span foreground=\\\"{label}\\\" weight=\\\"bold\\\">Vol:</span> <span foreground=\\\"{value}\\\">%s</span>\\n\", $2}}'",
        "interval": 1
    },
    {
            "name": "battery",
            "command": f"python3 /home/hugo/.config/i3blocks/scripts/battery.py "
            f"--label \"{colors['label']}\" --value \"{colors['value']}\" --low_battery_bg \"{colors['low_battery_bg']}\"",
            "interval": 60
    },   
    {
        "name": "pomodoro",
        "command": "tomaten status",
        "interval": 1
    },
    {
        "name": "pomodoro daily",
        "command": "tomaten daily-goal-status",
        "interval": 5
    }
]


def generate_config():
    lines = []
    for block in blocks:
        lines.append(f"[{block['name']}]")
        cmd = block['command'].format(label=colors['label'], value=colors['value'])
        lines.append(f"command={cmd}")
        lines.append(f"interval={block['interval']}")
        lines.append("markup=pango\n")
    return "\n".join(lines)

def main():
    config_content = generate_config()
    print(colors)
    with open(CONFIG_FILE, "w") as f:
        f.write(config_content)
    print(f"i3blocks config written to {CONFIG_FILE}")

if __name__ == "__main__":
    main()
