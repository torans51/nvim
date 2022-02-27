# Cheat sheet

* edit (or change current dir) `:e fileordir`
* close `:q` or `ZZ` or `:x` (works if all changes were saved)
* force close `:q!`
* close all `:qa`
* force close all `:qa!`
* write changes `:w`. Write all `:wa`
* exit all `:xa`. Exit and save all `:xa`
* undo/redo `u/<C-r>`
* copy a line `yy` (similar using selection with `v`)
* delete a line `dd` (similar using selection with `v`)
* move forward/backward by word `w/b`
* move at beginning/end of line `0/$`
* move at beginning/end of text line `^/$`
* move at the beginning/end of the document `gg/G`
* go to line 10 `10G` or `10gg` or `:10`
* scroll line to the tob/center/bottom `zt/zz/zb`
* move half-page down/up `<C-d>/<C-u>`
* insert before/after the cursor `i/a`
* insert at beginning/end of line `I/A`
* change to insert mode in the line before/after `O/o`
* change text inside parenthesis `ci(` (similar for `[,{,",'`)
* change text including parenthesis `ca(` (similar for `[,{,",'`)
* delete text inside parenthesis `di(` (similar for `[,{,",'`)
* delete text including parenthesis `da(` (similar for `[,{,",'`)
* enter in visual block mode `<C-v>`
* enter in visual line mode `V` (all line selected)
* repeat the last change `.`
* re-enter in visaul or visual block mode `gv`
* in visual block mode insert text vertical aligned using `Itexttoinsert <Esc>`
* move in tabs `gt/gT` `next tab/previous tab`
* move in buffers `:bnext/:bprevious` `next buffer/previous buffer`
* close a buffer `:bdelete`
* search forward `/searchthis`
* search backward `?searchthis`
* search in a visual selection use `v` before search
* move to next/previous search result `n/N`
* search globally and replace `:%s/searchthis/withthis`
* search globally and replace and asking confirmation `:%s/searchthis/withthis/c`
* search and replace in a visual selection use `v` before search (in cmd something like this appear `:'<, '>s/searchthis/replacethis`)
* split horizontal/vertical `:sp/:vsp`
* help for command `:help somecommand` (tab to use the autocomplete)
