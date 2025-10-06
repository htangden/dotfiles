import argparse
import subprocess

I3_CONFIG_PATH = "/home/hugo/dotfiles/i3/config"
ALACRITTY_CONFIG_PATH = "/home/hugo/dotfiles/alacritty/alacritty.toml"

# Colors for modes
MODES = {
    "dark": {
        "text": "#ebdbb2",
        "white": "#ebdbb2",
        "bg": "#282828",
        "highlight": "#458588",
        "alacritty_theme": "gruvbox_dark.toml",
        "nvim_theme": "gruvbox",
    },
    "light": {
        "text": "#14161b",
        "white": "#fbf1c7",
        "bg": "#e0e2ea",
        "highlight": "#14161b",
        "alacritty_theme": "hugos_light_theme.toml",
        "nvim_theme": "default",
    },
}

def update_i3_config(mode):
    with open(I3_CONFIG_PATH, "r") as f:
        lines = f.readlines()

    new_lines = []
    for line in lines:
        if line.startswith("set $text"):
            new_lines.append(f"set $text {MODES[mode]['text']}\n")
        elif line.startswith("set $bg"):
            new_lines.append(f"set $bg {MODES[mode]['bg']}\n")
        elif line.startswith("set $highlight"):
            new_lines.append(f"set $highlight {MODES[mode]['highlight']}\n")
        elif line.startswith("set $white"):
            new_lines.append(f"set $white {MODES[mode]['white']}\n")
        else:
            new_lines.append(line)    

    with open(I3_CONFIG_PATH, "w") as f:
        f.writelines(new_lines)


def update_alacritty_config(mode):
    content = f"""[general]
import = [
    "~/.config/alacritty/editor.toml",
    "~/.config/alacritty/themes/themes/{MODES[mode]['alacritty_theme']}"
]
"""
    with open(ALACRITTY_CONFIG_PATH, "w") as f:
        f.write(content)

def update_nvim_background(mode):
    NVIM_CONFIG_PATH = "/home/hugo/dotfiles/nvim/lua/hugo-tangden/editor.lua"
    
    with open(NVIM_CONFIG_PATH, "r") as f:
        lines = f.readlines()

    new_lines = []
    for line in lines:
        if line.strip().startswith("vim.o.background"):
            new_lines.append(f'vim.o.background = "{mode}"\n')
        elif line.strip().startswith("vim.cmd([[colorscheme"):
            print(f'Updating nvim theme to {MODES[mode]["nvim_theme"]}')
            new_lines.append(f'vim.cmd([[colorscheme {MODES[mode]["nvim_theme"]}]])\n')
        else:
            new_lines.append(line)

    with open(NVIM_CONFIG_PATH, "w") as f:
        f.writelines(new_lines)

def update_i3blocks_config(mode):
    I3BLOCKS_CONFIG_SCRIPT = "/home/hugo/dotfiles/i3blocks/scripts/createConfig.py"
   
    # Color presets per mode
    label_color = MODES[mode]['highlight']  # use highlight as label color
    value_color = MODES[mode]['text']       # use text as value color
    low_battery_bg = {
        "dark": "#cc241d",
        "light": "#9d0006",
    }[mode]

    # Call the script with correct arguments
    subprocess.run([
        "python3",
        I3BLOCKS_CONFIG_SCRIPT,
        "--label", label_color,
        "--value", value_color,
        "--low_battery_bg", low_battery_bg
    ])

def reload_i3():
    subprocess.run(["i3-msg", "reload"])

def main():
    parser = argparse.ArgumentParser(description="Switch i3 and Alacritty between dark and light mode.")
    parser.add_argument("--mode", choices=["dark", "light"], required=True, help="Choose dark or light mode")
    args = parser.parse_args()

    update_i3_config(args.mode)
    update_alacritty_config(args.mode)
    update_nvim_background(args.mode)
    update_i3blocks_config(args.mode)
    reload_i3()
    print(f"Switched to {args.mode} mode and reloaded i3 config.")

if __name__ == "__main__":
    main()
