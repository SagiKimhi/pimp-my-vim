syntax on

" cause who wants error bells?? ...
set noerrorbells
" Tab width, auto indentation, and search and replace case sens and highlighting
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smartcase
set nowrap
" line numbers and relative line numbers
set nu
set rnu
" an undo directory - works awesome with the undotree plugin
set undodir=~/.vim/undodir
set undofile
" additional personal preference sets, use :h <setting> to learn more about each set
set updatetime=500
set noswapfile
set nobackup
set noshowmode
set nohlsearch
set incsearch
set path+=**
set complete+=kspell
set completeopt=menuone,longest
set backspace=3
set textwidth=0
set mouse=a
set showcmd
set cursorline
set scrolloff=6
set signcolumn=yes
set colorcolumn=100
highlight ColorColumn ctermbg=0 guibg=lightgray
" defines which tag files vim should use for autocompletion
if (&filetype==# 'c' || &filetype==# 'cpp')
  set tags=~/.tags/C
else
  set tags=~/.tags
endif

" vim-plug plugin manager
call plug#begin('~/.vim/plugged')
"Color themes and various language syntax plugins
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
" Auto completion
Plug 'vim-scripts/AutoComplPop'
" file navigation and undotree plugins
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
" Im too lazy to explain everything else just look at the github pages...
Plug 'jremmen/vim-ripgrep'
Plug 'darrikonn/vim-gofmt'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'vim-utils/vim-man'
Plug 'tpope/vim-dispatch'
" Plug 'theprimeagen/vim-be-good' - awesome but optional read about it on github
Plug 'tpope/vim-projectionist'
Plug 'tomlion/vim-solidity'
" Optional - you can comment this out, read more about the plugin on the fzf
" github page to find out exactly what it is
Plug 'junegunn/fzf.vim'
Plug '~/.fzf'
call plug#end()

"Color theme settings - if you dont like this theme you can try out gruvbox plugin instead,
" its awesome as well (use it's dark theme)
if (has("autocmd"))
  augroup colorextend
    autocmd!
    " Make `Function`s bold in GUI mode
    autocmd ColorScheme * call onedark#extend_highlight("Function", { "gui": "bold" })
    " Override the `Statement` foreground color in 256-color mode
    autocmd ColorScheme * call onedark#extend_highlight("Statement", { "fg": { "cterm": 128 } })
    " Override the `Identifier` background color in GUI mode
    autocmd ColorScheme * call onedark#extend_highlight("Identifier", { "bg": { "gui": "#333333" } })
  augroup END
endif
let g:airline_theme='onedark'
let g:onedark_termcolors=256
let g:onedark_terminal_italics=1
colorscheme onedark

if executable('rg')
    let g:rg_derive_root='true'
endif
let g:go_version_warning = 0

"----------------------- Awesome key remaps -----------------------"
" Defines a <leader> keybind, change it if you wish,
" I found the spacebar to be super comfy and quick to use
let mapleader = " "
" Use ctrl+p to find navigate to files with an awesome quick recursive search
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25
"some specific snippet settings for c
let g:acp_mappingDriven = 1
" If you dont like the Nerdtree plugin and wish to use vim's original
" Ex tree, comment out the nerdtree remaps and uncomment the following remap:
" nnoremap <leader>pv :wincmd v<bar> :Ex<bar> :vertical resize 30<CR>
nnoremap <leader>pv :NERDTreeToggle<Enter> <bar> :vertical resize 25<CR>
nnoremap <leader>pf :NERDTreeFind<CR>
" Window navigation mappings:
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <Leader>ps :Rg<SPACE>
"Undotree - this is absolutley amazing!
nnoremap <leader>u :UndotreeShow<CR>
" Horizontal resize mappings:
nnoremap <silent><leader>r+ :res +5<CR>
nnoremap <silent><leader>r- :res -5<CR>
"Vertical resize mappings:
nnoremap <leader>vr :vertical resize 30<CR>
nnoremap <silent><leader>+ :vertical resize +5<CR>
nnoremap <silent><leader>- :vertical resize -5<CR>
"Auto Complete Keybind settings:
" Navigation with up and down, right arrow or return for completion, left arrow
" for cancelation
inoremap <expr> <Down> pumvisible() ? "<C-N>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-P>" :"<Up>"
inoremap <expr> <Right> pumvisible() ? "<C-Y>" :"<Right>"
inoremap <expr> <Left> pumvisible() ? "<C-E>" :"<Left>"
"delete what is marked, without saving it to paste reg, and paste whats currently saved
"to the paste register.
vnoremap <leader>p "_dP
" Moving lines along the file - these are so amazing! try out the visual mode
" setting! its a must i swear.
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <leader>J :m .+1<CR>==
nnoremap <leader>K :m .-2<CR>==
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==
" Keeps the cursor centered while jumping between definitions, Ctrl+j/k keeps it
" centered when navigating up/down through the file.
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
nnoremap <C-j> jzz
nnoremap <C-k> kzz
" A command to make ctags from within vim, sends the file straight to the tags
" folder, feel free to add commands and make directories for additional languages.
:command! MakeTags !ctags -f ~/.tags/tags
:command! MakeCTags !ctags -f ~/.tags/C/tags
