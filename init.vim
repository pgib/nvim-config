call plug#begin("~/.vim/plugged")
  " Plugin Section
  Plug 'dracula/vim'
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'jlanzarotta/bufexplorer'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-fugitive'
  Plug 'scrooloose/nerdcommenter'
  Plug 'folke/tokyonight.nvim'
  Plug 'phaazon/hop.nvim'
call plug#end()
"Config Section

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
"colorscheme dracula
let g:onedark_termcolors=256
set background=dark
"colorscheme gruvbox
let g:tokyonight_style = "night"
colorscheme tokyonight

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Load NERDtree if no files specified
"autocmd vimenter * if !argc() | NERDTree | endif
autocmd BufEnter * :syn sync maxlines=256

let mapleader = ","
nmap <Leader>, :NERDTreeToggle<cr>
nmap <Leader>bb :BufExplorer<cr>

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" simple back and forth between windows
map ` <C-W>w
map ~ <C-W>p

"-[ Indents and tabs ] {{{
  set tabstop=2                  " four is the best number ever (especially when combined with 2)
  set shiftwidth=2               " spaces for each step of (auto)indent
  "set autoindent                " maintain the current indentation when going to a new line
  set expandtab                  " expand tabs. tabs rip.
  set shiftround                 " always round indents to multiples of shiftindent
  set copyindent                 " use existing indents for new indents (?)
  set preserveindent             " save as much indent structure as possible
  filetype plugin indent on      " load filetype plugins and indent settings (haml needs spaces, for example)
  set backspace=2                " Backspace deletes like most programs in insert mode

  set formatoptions=qrn1
  "set colorcolumn=+1
  set undofile
  set undodir=~/.vim/undo        " undo across sessions

  " delete files older than 90 days
  let s:undos = split(globpath(&undodir, '*'), "\n")
  call filter(s:undos, 'getftime(v:val) < localtime() - (60 * 60 * 24 * 90)')
  call map(s:undos, 'delete(v:val)')
" }}}

"--------------- Console UI and text display
set laststatus=2               " always show the statusline
set title                      " sets the title of the terminal window
set ruler                      " a nice ruler
set number                     " line numbers? yes, please
set cul                        " hightlight the current line
set incsearch                  " live searching ftw!
set relativenumber             " relative line numbers

"set nocursorline              " slight performance improvement with this on

nnoremap <F1> :set invnumber number?<cr>:set invrelativenumber relativenumber?<cr>

nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" If installed using Homebrew
set rtp+=/opt/homebrew/opt/fzf
nmap ; :Buffers<CR>
" call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'}))
nmap <Leader>ff :Files<CR>
nmap <Leader>T :Tags<CR>
nmap <Leader>t :GitFiles<CR>
"nmap <Leader>t :call fzf#run(fzf#wrap({'source': 'git ls-files --exclude-standard --others --cached'}))<CR>
nmap <Leader>n :NERDTreeFind<CR>

" Copy and paste to and from the OS X clipboard
vmap <Leader>c y:call system("pbcopy", getreg("\""))<CR>
nmap <Leader>v :call setreg("\"",system("pbpaste"))<CR>p

" clear the last search highlight by pressing enter after a search
nnoremap <CR> :noh<CR><CR>

" Completion
let g:coc_global_extensions = ['coc-tabnine', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-eslint']
