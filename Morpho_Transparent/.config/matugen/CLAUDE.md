# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This is a [matugen](https://github.com/InioX/matugen) configuration directory. Matugen is a Material You color generation tool that takes a wallpaper image, generates a Material Design 3 color scheme from it, and applies those colors to app config files via templates.

## Running matugen

```bash
# Generate colors from a wallpaper image and apply all templates
matugen image /path/to/wallpaper.jpg

# Dry run (preview without writing output files)
matugen image /path/to/wallpaper.jpg --dry-run
```

## How it works

1. `config.toml` defines the templates and wallpaper command.
2. Each template in `templates/` is a config file for an app, with `{{colors.<role>.<variant>.hex}}` placeholders.
3. When matugen runs, it renders each template and writes the result to the `output_path` defined in `config.toml`.
4. After rendering, it calls the wallpaper command (`swww img --transition-type center`) to set the wallpaper.

## Template syntax

Color tokens follow the pattern `{{colors.<role>.<variant>.<format>}}`:

- **role**: Material You color role, e.g. `primary`, `secondary`, `tertiary`, `background`, `surface`, `error`, `on_background`, `primary_container`, `on_primary_container`, `surface_variant`, `on_surface_variant`, `surface_bright`, `surface_container`, `surface_container_highest`, `tertiary_fixed`, `on_tertiary_fixed`, `secondary_fixed`, `secondary_fixed_dim`, `on_surface`
- **variant**: `default`, `light`, or `dark`
- **format**: `hex` (with `#` prefix) or `hex_stripped` (without `#`, needed for Hyprland's `rgba(...)` syntax)

## Current templates

| Template | Output | Notes |
|---|---|---|
| `templates/kitty.conf` | `~/.config/kitty/kitty.conf` | Full config + colors |
| `templates/kitty-colors.conf` | (standalone, not in config.toml) | Colors only, reference template |
| `templates/hyprland.conf` | `~/.config/hypr/hyprland.conf` | Full config + colors |
| `templates/hyprlock.conf` | `~/.config/hypr/hyprlock.conf` | Full lockscreen config |
| `templates/starship.toml` | `~/.config/starship.toml` | Full prompt config |
| `templates/waybar.css` | `~/.config/waybar/style.css` | Full waybar stylesheet |
| `templates/swaync.css` | `~/.config/swaync/style.css` | Notification center |
| `templates/wofi.css` | `~/.config/wofi/style.css` | Launcher stylesheet |
| `templates/gtk-colors.css` | `~/.config/gtk-{3,4}.0/colors.css` | Standard GTK4 vars |
| `templates/neovim-colors.lua` | `~/.config/nvim/lua/colors/matugen.lua` | base16-colorscheme plugin |
| `templates/fastfetch.jsonc` | `~/.config/fastfetch/config.jsonc` | Fetch display colors |
| `templates/claude-theme.json` | `~/.claude/themes/mytheme.json` | Claude Code theme |
| `templates/kdeglobals` | `~/.config/kdeglobals` | KDE/Qt colors |

The `hyprland.conf` template is the full Hyprland config (not just colors), so editing it affects window manager behavior as well as theming.

## Color role guidelines

All templates use the `.dark` variant consistently. Key role mappings from the `reference/matugen-themes` repo:
- terminal background → `surface_container_lowest.dark`
- active border → `primary.dark` + `tertiary.dark` gradient
- inactive border → `outline_variant.dark`
- red terminal colors (color1/9) → `base16.base08.dark` with lighten filter
- green/yellow/blue/cyan/magenta → `*_fixed_dim` / `*_fixed` roles

In Material You dark scheme, `primary.dark` / `secondary.dark` etc. are **light tints** (designed as foreground on dark surfaces) — using them as backgrounds makes text hard to read. For segment backgrounds, prefer `*_container.dark` roles, which are the deep, saturated versions with enough contrast for light text on top.
