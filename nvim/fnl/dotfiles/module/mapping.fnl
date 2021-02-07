(module dotfiles.module.mapping
  {require {nvim aniseed.nvim
            nu aniseed.nvim.util
            util dotfiles.util
            core aniseed.core}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true}))

;; Leader is space key
(set nvim.g.mapleader " ")
;; LocalLeader is the comma key
(set nvim.g.maplocalleader ",")

;; packer
(util.nnoremap :pc "PackerClean")
(util.nnoremap :pg "PackerUpdate")
(util.nnoremap :pu "PackerSync")
(util.nnoremap :pi "PackerInstall")

;; Fugitive
(util.nnoremap :gs "vertical Git")
(util.nnoremap :gw "Gwrite")
(util.nnoremap :gc "Gcommit")
(util.nnoremap :gb "GBrowse")
(util.nnoremap :gy ".GBrowse!")

;; vim-better-whitespace
(util.nnoremap :sw "StripWhitespace")

;; fzf
(nvim.ex.command_
  "-bang -nargs=* Rg"
  "call fzf#vim#grep(\""
  "rg --column --line-number --no-heading --color=always --smart-case --hidden --follow -g '!.git/'"
  "-- \".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)")

(util.nnoremap :f "Files")
(util.nnoremap :<enter> "GitFiles")
(util.nnoremap :<leader> "Buffers")
(util.nnoremap :se "Rg")

(nvim.set_keymap :n :<leader><tab> "<plug>(fzf-maps-n)" {})
(nvim.set_keymap :x :<leader><tab> "<plug>(fzf-maps-x)" {})
(nvim.set_keymap :o :<leader><tab> "<plug>(fzf-maps-o)" {})

;; open-browser.vim
(nvim.ex.command_
  "-nargs=1 Browse"
  "OpenBrowser <args>")

(nvim.set_keymap :n :gx "<plug>(openbrowser-smart-search)" {})
(nvim.set_keymap :v :gx "<plug>(openbrowser-smart-search)" {})

;; vim-sneak
(nvim.ex.map :f "<plug>Sneak_f")
(nvim.ex.map :F "<plug>Sneak_F")
(nvim.ex.map :t "<plug>Sneak_t")
(nvim.ex.map :T "<plug>Sneak_T")

;; always move by visual lines, rather than real lines
;; this is useful when 'wrap' is set.
(noremap :n :j :gj {:silent true})
(noremap :n :k :gk {:silent true})
(noremap :v :j :gj {:silent true})
(noremap :v :k :gk {:silent true})

;; Navigate between matching brackets
;; These are specifically not `noremap`s because we want to be bound to
;; whatever % is (usually a plugin, matchit / matchup).
(nvim.set_keymap :n :<tab> :% {})
(nvim.set_keymap :v :<tab> :% {})

;; edit config files
(util.nnoremap :ev "e $HOME/.config/nvim/init.lua")
(util.nnoremap :ef "e $HOME/.config/fish/config.fish")
(util.nnoremap :eg "e $HOME/.config/git/config")

(util.nnoremap :w "w")
(util.nnoremap :q "q")
(util.nnoremap :cl "close")
(util.nnoremap :ss "split")
(util.nnoremap :vs "vsplit")

;; tab mappings
; (noremap :n (tostring :]r) ":tabn<cr>")
; (noremap :n (tostring :[r) ":tabp<cr>")
(noremap :n :<leader>tn ":tabnew<cr>")

;; Use Q to repeat last macro, rather than going into ex mode
(noremap :n :Q "@@")

;; Swap the behavior of the ^ and 0 operators
;; ^ Usually goes to the first non-whitespace character, while 0 goes to the
;; first column in the line. ^ is more useful, but harder to hit, so swap it
;; with 0
(noremap :n :0 "^")
(noremap :n :^ "0")

;; always center the screen after any movement command
(noremap :n :<C-d> "<C-d>zz")
(noremap :n :<C-f> "<C-f>zz")
(noremap :n :<C-b> "<C-b>zz")
(noremap :n :<C-u> "<C-u>zz")

(noremap :n :<leader>/ ":nohlsearch<cr>")

;; Keep the cursor in place while joining lines
(noremap :n :J "mzJ`z")

;; similar to vmap but only for visual mode - NOT select mode
;; maintains the currently visual selection between invocations of '<' and '>'
(noremap :x :< "<gv")
(noremap :x :> ">gv")

;; jk escape sequences.
(noremap :i :jk :<esc>)
(noremap :c :jk :<c-c>)
(noremap :t :jk :<c-\><c-n>)