(import-macros {: send-key!
                : send-string!} :macro.vim-like)

(fn concat [...]
  "Concatenate any number of sequential tables."
  (comment
    ;; When no parameter is passed a blank table is returned
    (concat) ; []
    ;; When a single table is passed a copy is returned
    (concat [:a :b]) ; [:a :b]
    ;; When 2 or more tables are passed they are concatenated in order
    (concat [:a :b] [:c :d]) ; [:a :b :c :d]
    (concat [:a :b] [:c :d] [:e :f]) ; [:a :b :c :d :e :f]
    ;; When a non-sequential table is passed it is considered an empty table
    (concat {:k1 :v1 :k2 :v2}) ; []
    ;; When a non-table parameter is passed an error is thrown
    (concat [:a :b] :c [:d :e]) ; runtime error: each parameter must be a table
    ;; A nil parameter is ignored
    (concat [:a :b] nil [:d :e]) ; [:a :b :d :e]
    )
  (local acc [])
  (for [i 1 (select "#" ...)]
    (local tbl (select i ...))
    (when (not= nil tbl)
      (assert (= :table (type tbl)) "each parameter must be a table")
      (each [_ it (ipairs tbl)]
        (table.insert acc it))))
  acc)

(local wezterm (require :wezterm))

(local config (wezterm.config_builder))

;; Always start with tmux with the default session
(set config.default_prog
     (if
       (wezterm.target_triple:find "darwin")
       ["/opt/homebrew/bin/tmux" "new-session" "-A" "-s" "default"]
       (wezterm.target_triple:find "windows")
       ["wsl" "tmux" "new-session" "-A" "-s" "default"]
       ["tmux" "new-session" "-A" "-s" "default"]))

;; Use Metal, Vulkan or DirectX 12
(set config.front_end "WebGpu")

;; Always start on the home directory
(set config.default_cwd wezterm.home_dir)

;; Font configuration
(set config.harfbuzz_features [:calt :liga=0 :dlig=0])
(set config.font (wezterm.font_with_fallback
                   ["Monaspace Argon"
                    "Symbols Nerd Font"]))
(set config.font_rules
     [;; Italic
      {:italic true
       :intensity "Normal"
       :font (wezterm.font "Monaspace Radon")}])
(set config.font_size 13.0)

;; Underline configuration
(set config.underline_position "200%")

;; Disable tab bar as we use tmux
(set config.enable_tab_bar false)

;; Disable scroll bar as we use tmux
(set config.enable_scroll_bar false)

;; Always close the pane as soon as the program dies
(set config.exit_behavior "Close")

;; Never display confirmation when closing window
(set config.window_close_confirmation "NeverPrompt")

;; Remove all padding
(set config.window_padding {:left 0
                            :right 0
                            :top 0
                            :bottom 0})

;; Don't change window size when changing font size
(set config.adjust_window_size_when_changing_font_size false)

;; Configure keybindings
(set config.keys
     (concat
       ;; MacOS exclusive keybinds
       (when (wezterm.target_triple:find "darwin")
         [;; MacOS behaviour reproduction
          {:key "v"          :mods "CMD" :action (wezterm.action.PasteFrom "Clipboard")} ; Paste from clipboard
          {:key "LeftArrow"  :mods "CMD" :action (send-key! "<Home>")}                   ; Move to the start
          {:key "RightArrow" :mods "CMD" :action (send-key! "<End>")}                    ; Move to the end
          {:key "Backspace"  :mods "CMD" :action (send-key! "<C-u>")}                    ; Delete to the start
          {:key "Backspace"  :mods "OPT" :action (send-key! "<C-w>")}                    ; Delete a word
          ;; Tmux keybinds for windows
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
          ;; Tmux keybinds for panes
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
          ;; Tmux keybinds for sessions
          {:key "s"          :mods "CMD"       :action (send-string! "<Leader>s")}       ; Interactively select session to attach
          {:key "["          :mods "SHIFT|CMD" :action (send-string! "<Leader>p")}       ; Switch to previous session
          {:key "{"          :mods "SHIFT|CMD" :action (send-string! "<Leader>p")}       ; Switch to previous session
          {:key "{"          :mods "CMD"       :action (send-string! "<Leader>p")}       ; Switch to previous session
          {:key "]"          :mods "SHIFT|CMD" :action (send-string! "<Leader>n")}       ; Switch to next session
          {:key "}"          :mods "SHIFT|CMD" :action (send-string! "<Leader>n")}       ; Switch to next session
          {:key "}"          :mods "CMD"       :action (send-string! "<Leader>n")}       ; Switch to next session
          ;; Miscellaneous tmux keybinds
          {:key "r"          :mods "CMD"       :action (send-string! "<Leader>r")}       ; Reload tmux configuration
          {:key ":"          :mods "SHIFT|CMD" :action (send-string! "<Leader>:")}       ; Open command-line
          ])))

;; Set color scheme
(set config.color_scheme "Catppuccin Mocha")

;; Return configuration
config
