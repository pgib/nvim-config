" Fix an indentation issue
let g:polyglot_disabled = ['jsx']

" Recommended to disable for NvimTree
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

call plug#begin("~/.vim/plugged")
  " Plugin Section
  Plug 'dracula/vim'
  Plug 'morhetz/gruvbox'
  "Plug 'scrooloose/nerdtree'
  Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'ryanoasis/vim-devicons'
  Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
  Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/vim-jsx-improve'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'jlanzarotta/bufexplorer'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-fugitive'
  Plug 'kdheepak/lazygit.nvim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'folke/tokyonight.nvim'
  Plug 'sainnhe/sonokai'
  Plug 'phaazon/hop.nvim'
  Plug 'farmergreg/vim-lastplace'
  Plug 'mrjones2014/dash.nvim', { 'do': 'make install' }
  "Plug 'feline-nvim/feline.nvim' " status line
  Plug 'nvim-lualine/lualine.nvim' " status line
  Plug 'neovim/nvim-lspconfig'
  Plug 'eandrju/cellular-automaton.nvim'
  Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
call plug#end()
"Config Section
"let g:polyglot_disabled = ['jsx']

if (has("termguicolors"))
 set termguicolors
endif
syntax enable
"colorscheme dracula
let g:onedark_termcolors=256
set background=dark
"colorscheme gruvbox
let g:tokyonight_style = "night"
"colorscheme tokyonight
"let g:sonokai_style = "default"
"let g:sonokai_style = "atlantis"
let g:sonokai_style = "andromeda"
"let g:sonokai_style = "shusia"
"let g:sonokai_style = "maia"
colorscheme sonokai

" Automaticaly close nvim if NERDTree is only thing left open
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Load NERDtree if no files specified
"autocmd vimenter * if !argc() | NERDTree | endif
autocmd BufEnter * :syn sync maxlines=256

"-- disable netrw at the very start of your init.lua (strongly advised)
"vim.g.loaded_netrw = 1
"vim.g.loaded_netrwPlugin = 1

"-- set termguicolors to enable highlight groups
"vim.opt.termguicolors = true

"-- empty setup using defaults
lua require("mason").setup()
lua require("nvim-tree").setup()
"lua require('feline').setup()
"lua require('feline').winbar.setup()
lua require('lspconfig').tsserver.setup({ filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" } })
lua require('lspconfig').solargraph.setup({ userconfig = {}})

lua <<EOF
require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<Tab>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  execlude_filetypes = {"TelescopePrompt"}
})
EOF

lua <<EOF
require('lualine').setup({
  tabline = {
    lualine_a = {},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  sections = {lualine_c = {'lsp_progress'}, lualine_x = {'tabnine'}},
  options = { theme  = 'OceanicNext' }
})
EOF

"-- OR setup with some options
"require("nvim-tree").setup({
"  sort_by = "case_sensitive",
"  view = {
"    adaptive_size = true,
"    mappings = {
"      list = {
"        { key = "u", action = "dir_up" },
"      },
"    },
"  },
"  renderer = {
"    group_empty = true,
"  },
"  filters = {
"    dotfiles = true,
"  },
"})

let mapleader = ","
"nmap <Leader>, :NERDTreeToggle<cr>
nmap <Leader>, :NvimTreeToggle<cr>
nmap <Leader>bb :BufExplorer<cr>
nmap <Leader>fml :CellularAutomaton make_it_rain<cr>

nnoremap <silent> <leader>lg :LazyGit<CR>

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
inoremap jk <Esc>

" simple back and forth between windows
map ` <C-W>w
map <Bslash> <C-W>w
map ~ <C-W>p
"map | <C-W>p

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
"nmap <Leader>n :NERDTreeFind<CR>
nmap <Leader>n :NvimTreeFindFile<CR>

" Copy and paste to and from the OS X clipboard
vmap <Leader>c y:call system("pbcopy", getreg("\""))<CR>
nmap <Leader>v :call setreg("\"",system("pbpaste"))<CR>p

" clear the last search highlight by pressing enter after a search
nnoremap <CR> :noh<CR><CR>

" Highlight trailing whitespace as an error
match errorMsg /\s\+$/

" Completion
"let g:coc_global_extensions = ['coc-tabnine', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-eslint']
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-eslint']
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" File-type overrides
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd bufnewfile,bufread *.jsx set filetype=javascript.jsx
