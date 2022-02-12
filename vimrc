set encoding=utf-8
scriptencoding utf-8

" NOTES:
" - Call :set list to show invisible characters.
" - Call :Stab to set tabstop = softtabstop = shiftwidth
" - Use F4 to toggle search highlight.
" - Use F5 to remove white spaces at the end of lines.
" - Use F7 to toggle the spelling. Move between suggestion using [s and ]s
" - use z= to see suggestions.
" - update the plugins calling :call minpac#update()
" - use ctrl+p and ctrl+n to navigate command history
" - use Q to search-next and replace


set nocompatible

set autoindent
set colorcolumn=80
set expandtab
set history=200
set incsearch
set listchars=tab:▸\ ,eol:¬
set nrformats=
set ruler
set shiftwidth=4
set softtabstop=4
set spelllang=en_us
set tabstop=4
colo murphy

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
"let g:netrw_liststyle=3     " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

if has('autocmd')

    augroup rss
        autocmd!
        " Treat .rss files as XML
        autocmd BufNewFile,BufRead *.rss setfiletype xml
    augroup END

    augroup trailingspaces
        autocmd!
        " Remove white spaces at lines' end when saving.
        autocmd BufWritePre *.py,*.js,*.R :call <SID>StripTrailingWhitespaces()
    augroup END

    augroup ctags
        autocmd!
        " Run ctags each time a source file is saved.
        autocmd BufWritePost *.py,*.js,*.R call system("ctags -R")
    augroup END

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



"---- Functions ----

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
    let l = line('.')
    let c = col('.')
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction



"---- Configure minpac ----
packadd minpac
call minpac#init()
call minpac#add('dense-analysis/ale')
call minpac#add('machakann/vim-highlightedyank')
call minpac#add('mileszs/ack.vim')
call minpac#add('nelstrom/vim-visual-star-search')
call minpac#add('tpope/vim-abolish')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim/killersheep', {'type': 'opt'})
call minpac#add('tpope/vim-fugitive', {'type': 'opt'})
call minpac#add('tpope/vim-scriptease', {'type': 'opt'})



"---- Abbreviations ----
:iabbrev adn  and
:iabbrev waht what
:iabbrev tehn then



"---- Remaps ----

let mapleader=','

:noremap           <F4>  :set hlsearch! hlsearch?<CR>
:noremap           <F7>  :set spell! spell?<CR>
:noremap  <Up>     <NOP>
:noremap  <Down>   <NOP>
:noremap  <Left>   <NOP>
:noremap  <Right>  <NOP>
:nnoremap <leader>ev     :vsplit $MYVIMRC<cr>  " open vimrc for a rapid change
:nnoremap <leader>sv     :source $MYVIMRC<cr>  " source vimrc
:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel " quote the current word
:nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel " quote the current word

" ALE configuration
let g:ale_linters_explicit = 1
let g:ale_sign_column_always=1
let g:ale_lint_on_text_changed='always'
let g:ale_lint_on_save=1
let g:ale_lint_on_enter=1
let g:ale_lint_on_filetype_changed=1
let g:ale_set_signs=0
" Only run these linters
let g:ale_linters = {
            \   'bib':        ['bibclean'],
            \   'c':          ['clang'],
            \   'cpp':        ['clangtidy'],
            \   'css':        ['prettier'],
            \   'html':       ['prettier', 'proselint', 'write-good'],
            \   'javascript': ['prettier', 'eslint'],
            \   'json':       ['prettier', 'jsonlint'],
            \   'markdown':   ['proselint', 'write-good'],
            \   'python':     ['pylint'],
            \   'r':          ['styler', 'lintr'],
            \   'sh':         ['shellcheck'],
            \   'tex':        ['chktex', 'proselint', 'write-good'],
            \   'text':       ['chktex', 'proselint', 'write-good'],
            \   'vim':        ['vint'],
            \   'xhtml':      ['proselint', 'write-good'],
            \   'xml':        ['xmllint'],
            \   'yaml':       ['yamllint'],
            \ }
" Jump among linter warnigns.
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)



" TODO: Review maps below.









" extent the ability of the % operator to keywords in some languages.
runtime macros/matchit.vim






"  Working with windows
" http://vimcasts.org/episodes/working-with-windows/
" Move between windows wihtout having to press Ctrl-w.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l



" Working with tabs
" http://vimcasts.org/episodes/working-with-tabs/
" Navigate tabs using the Ctrl key
map <C-S-]> gt
map <C-S-[> gT
map <C-1>  1gt
map <C-2>  2gt
map <C-3>  3gt
map <C-4>  4gt
map <C-5>  5gt
map <C-6>  6gt
map <C-7>  7gt
map <C-8>  8gt
map <C-9>  9gt
map <C-0>  :tablast<CR>




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

