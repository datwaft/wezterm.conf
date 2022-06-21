(local wezterm (require :wezterm))

{:default_prog ["wsl"]
 :default_cwd "\\\\wsl$\\Ubuntu\\home\\datwaft"
 :font (wezterm.font_with_fallback ["IBM Plex Mono"
                                    "BlexMono NF"])
 :color_scheme "Selenized Black"
 :enable_tab_bar false
 :enable_scroll_bar false
 :color_schemes {"Selenized Black" (require :selenized-black)}}
