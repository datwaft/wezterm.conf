(local wezterm (require :wezterm))

(fn is-windows? []
  (not= "/" (package.config:sub 1 1)))

{:default_prog (if (is-windows?)
                 ["wsl"]
                 ["zsh"])
 :default_cwd (if (is-windows?)
                "\\\\wsl$\\Ubuntu\\home\\datwaft"
                "~")
 :font (wezterm.font_with_fallback [{:family "IBM Plex Mono" :weight "Medium"}
                                    "BlexMono NF"])
 :font_size 10.0
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
