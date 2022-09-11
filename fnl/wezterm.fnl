(local wezterm (require :wezterm))

{:default_prog ["zsh"]
 :default_cwd wezterm.home_dir
 :font (wezterm.font_with_fallback ["JetBrains Mono" "Symbols Nerd Font"])
 :font_size 12.0
 :harfbuzz_features ["calt=0" "clig=0" "liga=0"] ; Disable ligatures
 :underline_position -6
 :underline_thickness 3
 :enable_tab_bar false
 :enable_scroll_bar false
 :exit_behavior "Close"
 :window_close_confirmation "NeverPrompt"
 :window_padding {:left 0
                  :right 0
                  :top 0
                  :bottom 0}
 :enable_csi_u_key_encoding true
 :adjust_window_size_when_changing_font_size false
 :color_scheme "Selenized Black"
 :color_schemes {"Selenized Black" (require :selenized-black)
                 "Selenized White" (require :selenized-white)}
 :keys [{:key "LeftArrow" :mods "CMD" :action (wezterm.action.SendKey {:key "Home"})}
        {:key "RightArrow" :mods "CMD" :action (wezterm.action.SendKey {:key "End"})}]}

