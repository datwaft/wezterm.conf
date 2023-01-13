;;; =========
;;; Utilities
;;; =========
(lambda range [from ?to ?step]
  (let [from (if (= nil ?to)
               (if (= 0 from) 0 (> from 0) 1 -1)
               from)
        to (if (= nil ?to) from ?to)
        step (or ?step (if (> to 0) 1 -1))]
    (values
      (if (> step 0) (fn [_ prev]
                       (let [val (+ prev step)]
                          (when (<= val to) val)))
        (< step 0) (fn [_ prev]
                     (let [val (+ prev step)]
                          (when (>= val to) val)))
        (fn [_ prev] prev))
      nil
      (- from step))))

(macro either [...]
  (let [symbols (fcollect [i 1 (length [...])] (gensym))
        let-bindings (accumulate [bindings []
                                  i expr (ipairs [...])]
                       (doto bindings
                         (table.insert (. symbols i))
                         (table.insert [expr])))
        if-body (accumulate [body []
                             i expr (ipairs [...])]
                  (doto body
                    (table.insert `(not= 0 (length ,(. symbols i))))
                    (table.insert `(unpack ,(. symbols i)))))]
    `(let ,let-bindings
       (if ,(unpack if-body)))))

;; Convert key codes to hex values
(local key->hex
  {"<C-b>"   "\x02"
   "<Up>"    "\x1b\x5b\x41"
   "<Down>"  "\x1b\x5b\x42"
   "<Right>" "\x1b\x5b\x43"
   "<Left>"  "\x1b\x5b\x44"})

;; Insert <Leader> key
(tset key->hex "<Leader>" (. key->hex "<C-b>"))

;; Insert 33..126 ASCII codes to key->hex
(collect [code (range 33 126) &into key->hex]
  (let [key (string.char code)
        hex (string.char code)]
    (values key hex)))

;;; ================
;;; Macro definition
;;; ================
(lambda send-key! [key]
  "Accepts an individual key using Vim's format (e.g. <Up> or <C-u>) and
  converts it to Wezterm format with the SendKey API."
  `(wezterm.action.SendKey
     ,(if
         ;; Is a key with modifier
         (key:match "<[CMD]%-%w>")
         (let [(mod key) (key:match "<([CMD])%-(%S)>")]
           {:key key
            :mods (match mod
                     "C" "CTRL"
                     "M" "OPT"
                     "D" "CMD")})
         ;; Is an special key
         (key:match "%b<>")
         (let [key (key:match "<(.*)>")]
           {:key key})
         ;; Is a normal key
         {:key key})))

(lambda ->tokens [input]
  "Obtain tokens from input.
  e.g.
    '<C-b>z' => ['<C-b>' 'z']
    '<C-b><Up>' => ['<C-b>' '<Up>']"
  (fn _internal [tokens input]
    (if (not= "" input)
      (let [(token input) (either
                            (input:match "(%b<>)(.*)")
                            (input:match "(%S)(.*)"))]
        (_internal (doto tokens (table.insert token)) input))
      tokens))
  (_internal [] input))

(lambda send-string! [str]
  "Accepts a string of keys using Vim's format (e.g. <C-b>z) and converts it to
  Wezterm format with the SendString API."
  `(wezterm.action.SendString
     ,(let [tokens (->tokens str)
             tokens (icollect [_ token (ipairs tokens)]
                      (. key->hex token))]
         (table.concat tokens ""))))

{: send-key!
 : send-string!}
