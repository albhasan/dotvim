" NOTES:
" - Call :set list to show invisible characters.
" - Call :Stab to set tabstop = softtabstop = shiftwidth
" - Use F4 to toggle search highlight.
" - Use F5 to remove white spaces at the end of lines.
" - Use F7 to toggle the spelling. Move between suggestion using [s and ]s
" - use z= to see suggestions.
" - update the plugins calling :call minpac#update()
" - use ctrl+p and ctrl+n to navigate command history


set nocompatible


set autoindent
set colorcolumn=80
set expandtab
"set hidden                   " Avoid message when switching among unsaved buffers.
set history=200
set incsearch
set listchars=tab:▸\ ,eol:¬
set nrformats=
"set number                   " Display line numbers.
set ruler
set shiftwidth=4
set softtabstop=4
set spelllang=en_us
set tabstop=4


syntax enable


filetype on
filetype indent on
filetype plugin on


" Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59


" Configuration of :find
set path+=** " search down into subfolders using :find
set wildmenu " display all matching files when we tab complete


" Tweaks for browsing :tabedit .
"let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
"let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


if has("autocmd")
    "
    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    "
    " Customisations based on house-style (arbitrary)
    autocmd FileType html       setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css        setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
    "
    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml
    "
    " Remove white spaces at lines' end when saving.
    autocmd BufWritePre *.py,*.js,*.R :call <SID>StripTrailingWhitespaces()
    "
    " Run ctags each time a source file is saved.
    autocmd BufWritePost *.py,*.js,*.R call system("ctags -R")
endif


" Use ctags with R. Getting Vim + Ctags Working with R https://tinyheero.github.io/2017/05/13/r-vim-ctags.html
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }


" Make the yanked region apparent (Not needed for NEOVIM) http://vimcasts.org/episodes/neovim-eyecandy/
if !exists('##TextYankPost')
    map y <Plug>(highlightedyank)
endif


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


" Configure minpac
packadd minpac
call minpac#init()
call minpac#add("dense-analysis/ale")
call minpac#add("machakann/vim-highlightedyank")
call minpac#add("mileszs/ack.vim")
call minpac#add("nelstrom/vim-visual-star-search")
call minpac#add("tpope/vim-abolish")
call minpac#add("tpope/vim-commentary")
call minpac#add("tpope/vim-surround")
call minpac#add("tpope/vim-unimpaired")
" Optional packages.
call minpac#add("vim/killersheep", {'type': 'opt'})
call minpac#add("tpope/vim-fugitive", {'type': 'opt'})
call minpac#add("tpope/vim-scriptease", {'type': 'opt'})


" Map F keys.
:noremap          <F4> :set hlsearch! hlsearch?<CR>
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>
:noremap          <F7> :set spell! spell?<CR>


" Avoid the cursor keys when recalling commands from history
map <C-p> <Up>
map <C-n> <Down>


" ALE configuration
let g:ale_linters_explicit = 1
let g:ale_sign_column_always=1
let g:ale_lint_on_text_changed='always'
let g:ale_lint_on_save=1
let g:ale_lint_on_enter=1
let g:ale_lint_on_filetype_changed=1
" Only run these linters
let g:ale_linters = {
            \   'css':  ['prettier'],
            \   'html':  ['prettier', 'proselint', 'write-good'],
            \   'javascript': ['prettier', 'eslint'],
            \   'json': ['prettier', 'jsonlint'],
            \   'markdown':  ['proselint', 'write-good'],
            \   'python': ['flake8'],
            \   'R': ['styler'],
            \   'sh': ['shellcheck'],
            \   'tex':  ['chktex', 'proselint', 'write-good'],
            \   'text': ['chktex', 'proselint', 'write-good'],
            \   'vim': ['vint'],
            \   'xhtml':  ['proselint', 'write-good'],
            \   'xml':  ['xmllint'],
            \   'yaml':  ['prettier'],
            \ }
" Jump among linter warnigns.
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)



" TODO: Review maps below.








" Use %% to expand 'edit' to the directory of the current buffer.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" extent the ability of the % operator to keywords in some languages.
runtime macros/matchit.vim

" search-next and replace using Q
nnoremap Q :normal n.<CR>

" Mute highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>


" fixing the & command
" practical vim page 241
" & is the same as :s which repeats the last substitution.
" no & fires :&& because it preserves flags and it is more consistent
nnoremap & :&&<CR>
xnoremap & :&&<CR>


"  Working with windows
" http://vimcasts.org/episodes/working-with-windows/
" Move between windows wihtout having to press Ctrl-w.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l



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


" The :edit command
" http://vimcasts.org/episodes/the-edit-command/
" Open a file relative to the current one
let mapleader=','
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>


" Soft wrapping text
" http://vimcasts.org/episodes/soft-wrapping-text/
"
" Break lines without breaking words.
" :set wrap
" :set linebreak
" :set nolist
"
" one liner
" :set wrap lbr nolist
"
" :Wrap function
command! -nargs=* Wrap set wrap linebreak nolist
"
" Moving around wrapperd lines using Cmd
vmap <C-j> gj
vmap <C-k> gk
vmap <C-4> g$ vmap <C-6> g^
vmap <C-0> g^
nmap <C-j> gj
nmap <C-k> gk
nmap <C-4> g$
nmap <C-6> g^
nmap <C-0> g^


" Bubble single lines
" http://vimcasts.org/episodes/bubbling-text/
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]


" Habit breaking, habit making
" http://vimcasts.org/blog/2013/02/habit-breaking-habit-making/
" Do NOT use the arrow keys!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
" Move more than one column or row at the time!
"noremap h <NOP>
"noremap j <NOP>
"noremap k <NOP>
"noremap l <NOP>


" create mappings to quickly traverse vim's lists
" pactical vim page 101
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


" Filter HTML through PANDOC
" The gq operation runs the selected text through the filter specified by formatprg
" http://vimcasts.org/episodes/using-external-filter-commands-to-reformat-html/
if has("autocmd")
  let pandoc_pipeline  = "pandoc --from=html --to=markdown"
  let pandoc_pipeline .= " | pandoc --from=markdown --to=html"
  autocmd FileType html let &l:formatprg=pandoc_pipeline
endif


" How to use tabs
" http://vimcasts.org/episodes/how-to-use-tabs/
" Each tab has its own directory, hence, each tab can hande a project.
" Use vimgrep to find a text in a project.


" Creating the Vimcasts logo as ASCII art
" http://vimcasts.org/episodes/creating-the-vimcasts-logo-as-ascii-art/


" Using the changelist and jumplist
" http://vimcasts.org/episodes/using-the-changelist-and-jumplist/
" The changelist remembers the position of every change that can be undone.
" :changes
" You can move back and forwards through the changelist using the commands:
" g;
" g,
"
" The jumplist remembers each position to which the cursor jumped,
" :jumps
" You can move backwards and forwards through the jumplist with the commands:
" ctrl-O
" ctrl-I


" Modal editing: undo, redo and repeat
" http://vimcasts.org/episodes/modal-editing-undo-redo-and-repeat/


" Hard wrapping text
" http://vimcasts.org/episodes/hard-wrapping-text/


" SyntaxHighlighter Vimscript brush and Blackboard theme
" http://vimcasts.org/blog/2010/04/syntaxhighlighter-vimscript-brush-and-blackboard-theme/


" Formatting text with par
" http://vimcasts.org/episodes/formatting-text-with-par/
" Format paragraphs in vim using an external program
" sudo apt install par


" Show invisibles
" http://vimcasts.org/episodes/show-invisibles/


" Tabs and Spaces
" http://vimcasts.org/episodes/tabs-and-spaces/

" Spell checking
" http://vimcasts.org/episodes/spell-checking/
"
" set spell
" set spelllang=en_gb
" move to the next misspelled word using ]s and back [s
" once over a misspelled word, use z= to see a list of suggestions


" Whitespace preferences and filetypes
" http://vimcasts.org/episodes/whitespace-preferences-and-filetypes/


" Tidying whitespace
" http://vimcasts.org/episodes/tidying-whitespace/


" Working with buffers
" http://vimcasts.org/episodes/working-with-buffers/


" unning Vim within IRB
" http://vimcasts.org/episodes/running-vim-within-irb/


" Converting markdown to structured HTML with a macro
" http://vimcasts.org/episodes/converting-markdown-to-structured-html-with-a-macro/


" Selecting columns with visual block mode
" http://vimcasts.org/episodes/selecting-columns-with-visual-block-mode/


" Press F4 to toggle highlighting on/off, and show current value.
" https://vim.fandom.com/wiki/Highlight_all_search_pattern_matches


" Refining search patterns with the command-line window
" http://vimcasts.org/episodes/refining-search-patterns-with-the-command-line-window/
" Replace single quotation marks with the right ones.


" Undo branching and Gundo.vim
" http://vimcasts.org/episodes/undo-branching-and-gundo-vim/


" visual star
" in visual mode, use * to search for the current selection instead of the
" current word
" practical vim page 227
" git clone https://github.com/nelstrom/vim-visual-star-search ~/dotvim/pack/bundle/start/vim-visual-star-search


" Set up netrd to look like NERDtree
" https://shapeshed.com/vim-netrw/#nerdtree-like-setup
"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END


" NOTE: It didn't work
" package management with minpaci https://github.com/k-takata/minpac
"packadd minpac
"call minpac#init()


" NOTE: It's annoying for editing regular text. Use colorcolumn=80 instead.
" Highlight text when it goes beyond 80 characters
" https://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/


"---
" Put these lines at the very end of your vimrc file.
" https://github.com/dense-analysis/ale#standard-installation
"
" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
"packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
"silent! helptags ALL

