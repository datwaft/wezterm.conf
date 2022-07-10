(local wezterm (require :wezterm))

(fn is-windows? []
  (not= "/" (package.config:sub 1 1)))

(fn scheme-for-appearance [appearance]
  (match appearance
    "dark" "Selenized Black"
    "light" "Selenized White"))

(wezterm.on "window-config-reloaded"
  (fn [window pane]
    (let [overrides (or (window:get_config_overrides) {})
          appearance (window:get_appearance)
          appearance (if (appearance.find "Dark") "dark" "light")
          scheme (scheme-for-appearance appearance)]
      (when (not= overrides.color_scheme scheme)
        (set overrides.color_scheme scheme)
        (window:set_config_overrides overrides)))))

{:default_prog (if (is-windows?)
                 ["wsl"]
                 ["zsh"])
 :default_cwd (if (is-windows?)
                "\\\\wsl$\\Ubuntu\\home\\datwaft"
                "~")
 :font (wezterm.font_with_fallback [{:family "IBM Plex Mono" :weight "Medium"}
                                    "BlexMono NF"])
 :font_size 12.0
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
 :color_schemes {"Selenized Black" (require :selenized-black)
                 "Selenized White" (require :selenized-white)}}
