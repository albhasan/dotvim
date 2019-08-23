syntax on

"---
" Show invisibles
" http://vimcasts.org/episodes/show-invisibles/
"
" Shortcut to rapidly toggle `set list`nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59


"----
" Tabs and Spaces
" http://vimcasts.org/episodes/tabs-and-spaces/

" Convert tab to white-spaces
"expandtab
" tabstop == softtabstop == shiftwidth

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction


"---
" Whitespace preferences and filetypes
" http://vimcasts.org/episodes/whitespace-preferences-and-filetypes/
" This required vim's autocmd enabled
if has("autocmd")
    " Enable file type detection
    filetype on

    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " Customisations based on house-style (arbitrary)
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml
endif


"---
" Tidying whitespace
" http://vimcasts.org/episodes/tidying-whitespace/

" Remove white spaces at the end of lines.
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Map the function to F5
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Run automatically when a python or javascript file is saved
autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

"---
"  Working with buffers 
" http://vimcasts.org/episodes/working-with-buffers/

" Avoid message when switching among unsaved buffers.
set hidden


"---
"  Working with windows 
" http://vimcasts.org/episodes/working-with-windows/
" Move between windows wihtout having to press Ctrl-w.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l


"---
" Working with tabs 
" http://vimcasts.org/episodes/working-with-tabs/
" Navigate tabs usind the Ctrl key
map <C-S-]> gt
map <C-S-[> gT
map <C-1> 1gt
map <C-2> 2gt
map <C-3> 3gt
map <C-4> 4gt
map <C-5> 5gt
map <C-6> 6gt
map <C-7> 7gt
map <C-8> 8gt
map <C-9> 9gt
map <C-0> :tablast<CR>


"---
" How to use tabs
" http://vimcasts.org/episodes/how-to-use-tabs/
" Each tab has its own directory, hence, each tab can hande a project.
" Use vimgrep to find a text in a project.


"---
" Creating the Vimcasts logo as ASCII art 
" http://vimcasts.org/episodes/creating-the-vimcasts-logo-as-ascii-art/


"---
" Using the changelist and jumplist 
" http://vimcasts.org/episodes/using-the-changelist-and-jumplist/
" The changelist remembers the position of every change that can be undone. 
" :changes
" You can move back and forwards through the changelist using the commands:
" g;
" g,

" The jumplist remembers each position to which the cursor jumped, 
" :jumps
" You can move backwards and forwards through the jumplist with the commands:
" ctrl-O
" ctrl-I


"---
" Modal editing: undo, redo and repeat 
" http://vimcasts.org/episodes/modal-editing-undo-redo-and-repeat/


"---
" The :edit command 
" http://vimcasts.org/episodes/the-edit-command/
" Open a file relative to the current one
let mapleader=','
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>


"---
" Soft wrapping text 
" http://vimcasts.org/episodes/soft-wrapping-text/

" Break lines without breaking words.
" :set wrap
" :set linebreak
" :set nolist

" one liner
" :set wrap lbr nolist

" :Wrap function 
command! -nargs=* Wrap set wrap linebreak nolist

" Moving around wrapperd lines using Cmd 
vmap <C-j> gj
vmap <C-k> gk
vmap <C-4> g$
vmap <C-6> g^
vmap <C-0> g^
nmap <C-j> gj
nmap <C-k> gk
nmap <C-4> g$
nmap <C-6> g^
nmap <C-0> g^



"----
" Hard wrapping text 
" http://vimcasts.org/episodes/hard-wrapping-text/


"----
" SyntaxHighlighter Vimscript brush and Blackboard theme 
" http://vimcasts.org/blog/2010/04/syntaxhighlighter-vimscript-brush-and-blackboard-theme/

"----
" Formatting text with par 
" http://vimcasts.org/episodes/formatting-text-with-par/
" Format paragraphs in vim using an external program
" sudo apt install par


"----
" Spell checking 
" http://vimcasts.org/episodes/spell-checking/

" set spell
" set spelllang=en_gb
" move to the next misspelled word using ]s and back [s
" once over a misspelled word, use z= to see a list of suggestions

" Toggle spell checking on and off with `,s`
let mapleader = ","
nmap <silent> <leader>s :set spell!<CR>

" Set region to British English
set spelllang=en_gb


" ----
" unning Vim within IRB 
" http://vimcasts.org/episodes/running-vim-within-irb/


"---
" Converting markdown to structured HTML with a macro 
" http://vimcasts.org/episodes/converting-markdown-to-structured-html-with-a-macro/


"----
" Selecting columns with visual block mode
" http://vimcasts.org/episodes/selecting-columns-with-visual-block-mode/

"----
" Press F4 to toggle highlighting on/off, and show current value.
" https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches
:noremap <F4> :set hlsearch! hlsearch?<CR>



"----
" Bubble single lines
" http://vimcasts.org/episodes/bubbling-text/
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]
