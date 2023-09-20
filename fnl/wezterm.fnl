(import-macros {: send-key!
                : send-string!} :macro.vim-like)

(local wezterm (require :wezterm))

(local keys
   [;;; ============================
    ;;; MacOS behaviour-reproduction
    ;;; ============================
    {:key "v"          :mods "CMD" :action (wezterm.action.PasteFrom "Clipboard")} ; Paste from clipboard
    {:key "LeftArrow"  :mods "CMD" :action (send-key! "<Home>")}                   ; Move to the start
    {:key "RightArrow" :mods "CMD" :action (send-key! "<End>")}                    ; Move to the end
    {:key "Backspace"  :mods "CMD" :action (send-key! "<C-u>")}                    ; Delete to the start
    {:key "Backspace"  :mods "OPT" :action (send-key! "<C-w>")}                    ; Delete a word
    ;;; =============
    ;;; Tmux keybinds
    ;;; =============
    ;; Windows
    {:key "t"          :mods "CMD"       :action (send-string! "<Leader>c")}       ; Open new window
    {:key "1"          :mods "CMD"       :action (send-string! "<Leader>1")}       ; Select window  1
    {:key "2"          :mods "CMD"       :action (send-string! "<Leader>2")}       ; Select window 2
    {:key "3"          :mods "CMD"       :action (send-string! "<Leader>3")}       ; Select window 3
    {:key "4"          :mods "CMD"       :action (send-string! "<Leader>4")}       ; Select window 4
    {:key "5"          :mods "CMD"       :action (send-string! "<Leader>5")}       ; Select window 5
    {:key "6"          :mods "CMD"       :action (send-string! "<Leader>6")}       ; Select window 6
    {:key "7"          :mods "CMD"       :action (send-string! "<Leader>7")}       ; Select window 7
    {:key "8"          :mods "CMD"       :action (send-string! "<Leader>8")}       ; Select window 8
    {:key "9"          :mods "CMD"       :action (send-string! "<Leader>9")}       ; Select window 9
    ;; Panes
    {:key "w"          :mods "CMD"       :action (send-string! "<Leader>x")}       ; Kill current pane (or window if it's the last pane)
    {:key "n"          :mods "CMD"       :action (send-string! "<Leader>%")}       ; Split current pane vertically
    {:key "N"          :mods "SHIFT|CMD" :action (send-string! "<Leader>\"")}      ; Split current pane horizontally
    {:key "z"          :mods "CMD"       :action (send-string! "<Leader>z")}       ; Zoom to current pane
    {:key "UpArrow"    :mods "SHIFT|CMD" :action (send-string! "<Leader><Up>")}    ; Move to pane upwards
    {:key "DownArrow"  :mods "SHIFT|CMD" :action (send-string! "<Leader><Down>")}  ; Move to pane downwards
    {:key "RightArrow" :mods "SHIFT|CMD" :action (send-string! "<Leader><Right>")} ; Move to pane on the right
    {:key "LeftArrow"  :mods "SHIFT|CMD" :action (send-string! "<Leader><Left>")}  ; Move to pane on the left
    {:key "k"          :mods "SHIFT|CMD" :action (send-string! "<Leader><Up>")}    ; Move to pane upwards
    {:key "j"          :mods "SHIFT|CMD" :action (send-string! "<Leader><Down>")}  ; Move to pane downwards
    {:key "h"          :mods "SHIFT|CMD" :action (send-string! "<Leader><Right>")} ; Move to pane on the right
    {:key "l"          :mods "SHIFT|CMD" :action (send-string! "<Leader><Left>")}  ; Move to pane on the left
    ;; Sessions
    {:key "s"          :mods "CMD"       :action (send-string! "<Leader>s")}       ; Interactively select session to attach
    {:key "["          :mods "SHIFT|CMD" :action (send-string! "<Leader>p")}       ; Switch to previous session
    {:key "{"          :mods "SHIFT|CMD" :action (send-string! "<Leader>p")}       ; Switch to previous session
    {:key "{"          :mods "CMD"       :action (send-string! "<Leader>p")}       ; Switch to previous session
    {:key "]"          :mods "SHIFT|CMD" :action (send-string! "<Leader>n")}       ; Switch to next session
    {:key "}"          :mods "SHIFT|CMD" :action (send-string! "<Leader>n")}       ; Switch to next session
    {:key "}"          :mods "CMD"       :action (send-string! "<Leader>n")}       ; Switch to next session
    ;; Miscellaneous
    {:key "r"          :mods "CMD"       :action (send-string! "<Leader>r")}       ; Reload tmux configuration
    {:key ":"          :mods "SHIFT|CMD" :action (send-string! "<Leader>:")}])     ; Open command-line

(local default_prog
  (if
    (wezterm.target_triple:find "darwin") ["/opt/homebrew/bin/tmux" "new-session" "-A" "-s" "default"]
    (wezterm.target_triple:find "windows") ["wsl" "tmux" "new-session" "-A" "-s" "default"]
    ["tmux" "new-session" "-A" "-s" "default"]))

{:front_end "WebGpu"
 :default_prog default_prog
 :default_cwd wezterm.home_dir
 :font (wezterm.font_with_fallback ["Iosevka"
                                    "Symbols Nerd Font"])
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
 :color_scheme "Catppuccin Mocha"
 :color_schemes {"Selenized Black" (include :selenized-black)
                 "Selenized White" (include :selenized-white)}
 : keys}
