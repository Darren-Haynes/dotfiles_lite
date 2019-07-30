"  __     __    __  __ ____   ____
"  \ \   / /_ _|  \/  |  _ \ / ___|
"   \ \ / / | || |\/| | |_) | |
"    \ V /  | || |  | |  _ <| |___
"     \_/  |___|_|  |_|_| \_\\____|


"""""""""""""""""""""""""""""""""""""
               "PLUG
"""""""""""""""""""""""""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Make Pretty
Plug 'kien/rainbow_parentheses.vim'
Plug 'danielmiessler/VimBlog'
Plug 'maralla/completor.vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline-themes'
Plug 'mbbill/undotree'

call plug#end()

""""""""""""""""""""""""""""""""""""""
            "DEFAULTS
""""""""""""""""""""""""""""""""""""""

filetype plugin on

" yank text to system clipboard (requires +clipboard)
set clipboard^=unnamedplus

" enable line numbers
set number

" ask confirmation for certain things like when quitting before saving
set confirm


set shortmess+=aAcIws   " Hide certain messages like 'Search Hit Bottom' etc.
set expandtab           " Tab inserts Spaces not Tabs '\t'
set softtabstop=4       " Amount of spaces to enter when Tab is pressed
set shiftwidth=4        " 4 space indentation
set tabstop=4
"set scrolloff=5         "show 5 lines above/below cursor
set showbreak=↪
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
" set matchpairs+=<:> "especially handy for html
set undofile " Maintain undo history
set undodir=~/.vim/undodir
set ignorecase " ignore case when searching
set smartcase
set noswapfile

" Stop autocommenting on next line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" enable mouse, sgr is better but not every term supports it
set mouse=a
if has('mouse_sgr')
    set ttymouse=sgr
endif

" syntax highlighting with true colors in the terminal
syntax enable
if has('termguicolors')
    if &term =~? 'screen\|tmux'
        set t_8f=^[[38;2;%lu;%lu;%lum
        set t_8b=^[[48;2;%lu;%lu;%lum
    endif
    set termguicolors
endif

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif


" bracketed paste while in insert mode, bracketed paste preserves indentation
inoremap <silent><C-v> <Esc>:set paste<CR>a<C-r>+<Esc>:set nopaste<CR>a

" better defaults
nnoremap 0 ^
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <Tab> ==j
nnoremap g; g;zz

" better motions with wrapped text while preserving numbered jumps
for g:key in ['k', 'j', '<Up>', '<Down>']
    execute 'noremap <buffer> <silent> <expr> ' .
                \ g:key . ' v:count ? ''' .
                \ g:key . ''' : ''g' . g:key . ''''
    execute 'onoremap <silent> <expr> ' .
                \ g:key . ' v:count ? ''' .
                \ g:key . ''' : ''g' . g:key . ''''
endfor

augroup file_load_change_and_position
    " clear this group so they don't pile up
    autocmd!

    " when quitting, save position in file
    " when re-opening go to last position
    autocmd BufReadPost * call setpos(".", getpos("'\""))

    " Reload changes if file changed outside of vim
    " requires autoread (enabled by default)
    autocmd FocusGained,BufEnter * if mode() !=? 'c' | checktime | endif
    autocmd FileChangedShellPost * echo "Changes loaded from file"
augroup END

set tags=tags


""""""""""""""""""""""""""""""""""""""
            "WILDMENU
""""""""""""""""""""""""""""""""""""""

" enable tab completion menu when using colon command mode (:)
set wildmenu
set wildignore+=*/tmp/*,*.so,*.zip               " Linux
set wildignore+=*.pyc,*.out                      " Compiled files
set wildignore+=__pycache__						 " Py cache folder
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files


"""""""""""""""""""""""""""""""""""""""
           " VIM COLORS
"""""""""""""""""""""""""""""""""""""""

highlight SignColumn guibg=NONE
highlight SignColumn ctermbg=NONE
highlight TabLineFill guibg=#2C313C
highlight TabLineFill ctermbg=NONE
highlight TabLineFill ctermbg=NONE
highlight TabLineSel ctermbg=110
highlight TabLineSel ctermfg=NONE
highlight TabLine ctermbg=NONE
highlight TabLine ctermfg=NONE
highlight Visual ctermbg=124
highlight VertSplit guibg=NONE

" let g:lightline = {
      " \ 'colorscheme': 'one',
      " \ }

" colorscheme onedark

hi Normal guibg=NONE ctermbg=NONE
highlight VertSplit cterm=NONE


"""""""""""""""""""""""""""""""""""""""
           " LET THE GAMES BEGIN
"""""""""""""""""""""""""""""""""""""""

filetype plugin on

"""""""""""""""""""""""""""""""""""""""
           " VERSION CONTROL
"""""""""""""""""""""""""""""""""""""""

nnoremap <leader>cp :! clasp push<CR>


"""""""""""""""""""""""""""""""""""""""
           " SESSION MANAGEMENT
"""""""""""""""""""""""""""""""""""""""

let g:session_directory = "~/.vim/sessions"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

nnoremap <leader>ss :SaveSession
nnoremap <leader>so :OpenSession
nnoremap <leader>sd :DeleteSession
nnoremap <leader>sc :CloseSession


"Split as you expect splits to split.
set splitright
set splitbelow

"Set leader key to spacebar. You know it makes sense
let mapleader = " "

" Open window in new tab (My preferred way to 'zoom' a window.)
nnoremap <leader>z :tabnew %<CR>

" make horizontal split full height
nnoremap <leader>ru <C-w><C-_>
" make vertical split full width
nnoremap <leader>rw <C-w>\|
" make split full screen (full width and height)
nnoremap <leader>rf <C-w><C-_><C-w>\|

" make splits equal size
nnoremap <leader>r= <C-w>=

" increase width by 5
nnoremap <leader>rl :vertical resize +5<CR>
" decrease width by 5
nnoremap <leader>rh :vertical resize -5<CR>
" increase height by 5
nnoremap <leader>rk :res +5<CR>
" decrease height by 5
nnoremap <leader>rj :res -5<CR>

" increase width by 1
nnoremap <leader>rL :vertical resize +1<CR>
" decrease width by 1
nnoremap <leader>rH :vertical resize -1<CR>
" increase height by 1
nnoremap <leader>rK :res +1<CR>
" decrease height by 1
nnoremap <leader>rJ :res -1<CR>

" resize for different widths
nnoremap <leader>r8 :vertical resize 80<CR>
nnoremap <leader>r9 :vertical resize 90<CR>
nnoremap <leader>r0 :vertical resize 100<CR>
nnoremap <leader>r1 :vertical resize 110<CR>
nnoremap <leader>r2 :vertical resize 120<CR>
nnoremap <leader>r3 :vertical resize 130<CR>
nnoremap <leader>r4 :vertical resize 140<CR>


"""""""""""""""""""""""""""""""""""""""
           " TAB MANAGEMENT
"""""""""""""""""""""""""""""""""""""""

nnoremap <leader>tl :tabnext<CR>
nnoremap <leader>th :tabnext<CR>


""""""""""""""""""""""""""""""""
           "NAVIGATION
""""""""""""""""""""""""""""""""

" Disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" j,k move by screen line instead of file line
nnoremap j gj
nnoremap k gk


""""""""""""""""""""""""""""""""
           "SED
""""""""""""""""""""""""""""""""

" Capital case all words on current line
nnoremap <leader>cp :s/\<./\u&/g <CR>


""""""""""""""""""""""""""""""""
        "PYTHON PATHS
""""""""""""""""""""""""""""""""

let g:python_host_prog="/home/darren/.pyenv/versions/neovim2/bin/python"
let g:python3_host_prog="/home/darren/.pyenv/versions/neovim3/bin/python"

"""""""""""""""""""""""""""""""""""""""""""""""""
              "OPEN CONFIG FILES
                 "SHORTCUTS
"""""""""""""""""""""""""""""""""""""""""""""""""

"Use leader to source vimrc and ftplugins
nnoremap <leader>sv :source $MYVIMRC<CR>

" Open config files in vertical splits
nnoremap <leader>ev :vsplit ~/.vimrc<CR>
nnoremap <leader>ep :vsplit ~/.vim/after/ftplugin/python.vim<CR>
nnoremap <leader>ej :vsplit ~/.vim/after/ftplugin/javascript.vim<CR>
nnoremap <leader>eh :vsplit ~/.vim/after/ftplugin/html.vim<CR>
nnoremap <leader>ec :vsplit ~/.vim/after/ftplugin/css.vim<CR>
nnoremap <leader>ea :vsplit ~/.aliases<CR>
nnoremap <leader>eb :vsplit ~/.bashrc<CR>
nnoremap <leader>ez :vsplit ~/.zshrc<CR>
nnoremap <leader>ex :vsplit ~/.Xresources<CR>
nnoremap <leader>ei :vsplit ~/.config/i3/config<CR>
nnoremap <leader>eq :vsplit ~/.config/qutebrowser/qutebrowser.conf<CR>
nnoremap <leader>ei :vsplit ~/.config/termite/config<CR>
nnoremap <leader>eml :vsplit ~/.tmux.conf.local<CR>
nnoremap <leader>emg :vsplit ~/.tmux.conf<CR>
nnoremap <leader>et :vsplit ~/.config/alacritty/alacritty.yml<CR>


""""""""""""""""""""""""""""""""
          "INSERT MODE
          "TWEAKS
""""""""""""""""""""""""""""""""

" return in normal mode like return in insert mode
nnoremap <CR> a<CR>
nnoremap <Tab> i<space><space><space><space>

""""""""""""""""""""""""""""""""""""""
             "TOGGLE
            "SETTINGS
""""""""""""""""""""""""""""""""""""""

" Toggle spell check
nnoremap <leader>sp :setlocal spell! spelllang=en_us<CR>
nnoremap <leader>sl ]s
nnoremap <leader>sh [s
nnoremap <leader>sa zg
nnoremap <leader>sn z=

" Toggle highlight search
let hlstate=0
nnoremap <leader>hl :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr><cr>

" Toggle relative or absolute number lines
nnoremap <leader>tn :call NumberToggle()<CR>

function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction


""""""""""""""""""""""""""""""""""""""
            "WHITE SPACE
""""""""""""""""""""""""""""""""""""""

" trim trailing whitespace on file save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"convert tabs to spaces
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
"convert spaces to tab
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

""""""""""""""""""""""""""""""""""""""
            "PLUGIN
            "SETTINGS
""""""""""""""""""""""""""""""""""""""
" Vim Sessions
set sessionoptions-=buffers
let g:session_autosave="yes"
let g:session_autosave_periodic=0
let g:session_lock_enabled = 0

" UNDOTREE
nnoremap <leader>tu :UndotreeToggle<CR>

" TABOO
let g:taboo_tab_format = "%N~%f|"

" RAINBOWS
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
nnoremap <Leader>tr :RainbowParenthesesToggle<CR>


""""""""""""""""""""""""""""""""""""""
            "ABBREVIATIONS
""""""""""""""""""""""""""""""""""""""

iabbrev bb #!/bin/bash<cr>
iabbrev bp #!/bin/env python
iabbrev DH Darren Haynes
iabbrev VH Veronica Haynes
iabbrev ns1 nameserver 1.1.1.1

" source $HOME/.private_dotfiles/.priv_vimrc

""""""""""""""""""""""""""""""""""""""
            "LINUXY
            "THINGS
""""""""""""""""""""""""""""""""""""""
nnoremap <leader>cw :! wc -w %:p<CR>
nnoremap <leader>cl :! wc -l %:p<CR>

" Complie and exec c file
nnoremap <Leader>mc :! gcc & ./a.out<CR>


""""""""""""""""""""""""""""""""""""""
            "WORPRESS
            "EDITING
""""""""""""""""""""""""""""""""""""""

nnoremap <leader>h1 <esc>I<h1><esc>A</h1><esc>0
nnoremap <leader>h2 <esc>I<h2><esc>A</h2><esc>0
nnoremap <leader>h3 <esc>I<h3><esc>A</h3><esc>0
nnoremap <leader>h4 <esc>I<h4><esc>A</h4><esc>0
nnoremap <leader>h5 <esc>I<h5><esc>A</h5><esc>0
nnoremap <leader>h6 <esc>I<h6><esc>A</h6><esc>0
