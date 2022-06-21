(local wezterm (require :wezterm))

{:default_prog ["wsl"]
 :default_cwd "\\\\wsl$\\Ubuntu\\home\\datwaft"
 :font (wezterm.font_with_fallback ["IBM Plex Mono"
                                    "BlexMono NF"])
 :color_scheme "Selenized Black"
 :enable_tab_bar false
 :enable_scroll_bar false
 :exit_behavior "Close"
 :window_close_confirmation "NeverPrompt"
 :window_padding {:left 0
                  :right 0
                  :top 0
                  :bottom 0}
 :color_schemes {"Selenized Black" (require :selenized-black)}}
