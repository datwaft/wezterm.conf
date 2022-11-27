(local wezterm (require :wezterm))

{:default_prog ["/opt/homebrew/bin/tmux" "new-session" "-A" "-s" "default"]
 :default_cwd wezterm.home_dir
 :font (wezterm.font "Fantasque Sans Mono")
 :font_size 13.0
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
        {:key "RightArrow" :mods "CMD" :action (wezterm.action.SendKey {:key "End"})}
        {:key "Backspace" :mods "CMD" :action (wezterm.action.SendKey {:key "u" :mods "CTRL"})}
        {:key "Backspace" :mods "OPT" :action (wezterm.action.SendKey {:key "w" :mods "CTRL"})}
        ; Tmux keybinds using CMD key
        {:key "t" :mods "CMD" :action (wezterm.action.SendString "\x02\x63")} ; <C-b>c: Open new window
        {:key "," :mods "CMD" :action (wezterm.action.SendString "\x02\x2c")} ; <C-b>,: Rename current window
        {:key "1" :mods "CMD" :action (wezterm.action.SendString "\x02\x31")} ; <C-b>1: Select window 1
        {:key "2" :mods "CMD" :action (wezterm.action.SendString "\x02\x32")} ; <C-b>2: Select window 2
        {:key "3" :mods "CMD" :action (wezterm.action.SendString "\x02\x33")} ; <C-b>3: Select window 3
        {:key "4" :mods "CMD" :action (wezterm.action.SendString "\x02\x34")} ; <C-b>4: Select window 4
        {:key "5" :mods "CMD" :action (wezterm.action.SendString "\x02\x35")} ; <C-b>5: Select window 5
        {:key "6" :mods "CMD" :action (wezterm.action.SendString "\x02\x36")} ; <C-b>6: Select window 6
        {:key "7" :mods "CMD" :action (wezterm.action.SendString "\x02\x37")} ; <C-b>7: Select window 7
        {:key "8" :mods "CMD" :action (wezterm.action.SendString "\x02\x38")} ; <C-b>8: Select window 8
        {:key "9" :mods "CMD" :action (wezterm.action.SendString "\x02\x39")} ; <C-b>9: Select window 9
        {:key "w" :mods "CMD" :action (wezterm.action.SendString "\x02\x78")} ; <C-b>x: Kill current pane (or window if it's the last pane)
        {:key "s" :mods "CMD" :action (wezterm.action.SendString "\x02\x73")} ; <C-b>s: Interactively select session to attach
        {:key "{" :mods "SHIFT|CMD" :action (wezterm.action.SendString "\x02\x70")} ; <C-b>p: Switch to previous session
        {:key "}" :mods "SHIFT|CMD" :action (wezterm.action.SendString "\x02\x6e")} ; <C-b>n: Switch to next session
        {:key "n" :mods "CMD" :action (wezterm.action.SendString "\x02\x25")} ; <C-b>%: Split current pane vertically
        {:key "N" :mods "SHIFT|CMD" :action (wezterm.action.SendString "\x02\x22")} ; <C-b>": Split current pane horizontally
        {:key "z" :mods "CMD" :action (wezterm.action.SendString "\x02\x7a")} ;<C-b>z: Zoom to current pane
        {:key "UpArrow" :mods "SHIFT|CMD" :action (wezterm.action.SendString "\x02\x1b\x5b\x41")} ; <C-b><up>: Move to pane upwards
        {:key "DownArrow" :mods "SHIFT|CMD" :action (wezterm.action.SendString "\x02\x1b\x5b\x42")} ; <C-b><down>: Move to pane downwards
        {:key "RightArrow" :mods "SHIFT|CMD" :action (wezterm.action.SendString "\x02\x1b\x5b\x43")} ; <C-b><right>: Move to pane on the right
        {:key "LeftArrow" :mods "SHIFT|CMD" :action (wezterm.action.SendString "\x02\x1b\x5b\x44")} ; <C-b><left>: Move to pane on the left
        {:key "r" :mods "CMD" :action (wezterm.action.SendString "\x02\x72")}]} ;<C-b>r: Reload tmux configuration
