(local wezterm (require :wezterm))

{:default_prog ["wsl"]
 :default_cwd "\\\\wsl$\\Ubuntu\\home\\datwaft"
 :font (wezterm.font_with_fallback ["IBM Plex Mono"
                                    "BlexMono NF"])}
