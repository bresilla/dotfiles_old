call plug#begin()
    "SYNTAX
    Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
    Plug 'ncm2/float-preview.nvim'
    Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
    Plug 'sheerun/vim-polyglot'           	"A collection of language packs for Vim
	Plug 'w0rp/ale'                       	"syntax checker for vim
    Plug 'SirVer/ultisnips'               	"snipets engine
    Plug 'honza/vim-snippets'             	"snippets collection
    Plug 'ntpeters/vim-better-whitespace' 	"whitespace detection
    Plug 'rhysd/vim-grammarous'           	"gramar checker
    Plug 'lfilho/cosco.vim'               	"add semicolon or comma n the end
    Plug 'lilydjwg/colorizer'             	"show hex colors
    "WORKSPACE
    Plug 'vim-ctrlspace/vim-ctrlspace'    	"a better workspace manager
    Plug 'benmills/vimux'                 	"run shell comands in a tmux pane
    Plug 'christoomey/vim-tmux-navigator'
	Plug 'voldikss/vim-floaterm'		  	"terminal
	Plug 'ingolemo/vim-bufferclose'
    Plug '907th/vim-auto-save'            	"vim autsave plugin
    Plug 'editorconfig/editorconfig-vim'  	"EDITOR-CONFIG settings
    "THEME
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'
    Plug 'edkolev/promptline.vim'
    Plug 'powerline/fonts'                	"patched powerline-fonts
    Plug 'rakr/vim-one'                   	"Atom ONE theme
    "NAVIGATION
    Plug 'easymotion/vim-easymotion'      	"jump to any location
    Plug 'matze/vim-move'                 	"move lines with alt-arrow
    Plug 'yuttie/comfortable-motion.vim'  	"comfortable scroll
    Plug 'tpope/vim-repeat'               	" '.' for better repeat functioalities
    "VIEWS
	Plug 'scrooloose/nerdtree'            	"side-bar file manager
    Plug 'ryanoasis/vim-devicons'         	"icons for nerdtree
    Plug 'zgpio/tree.nvim'                  "better file browser
    Plug 'mcchrish/nnn.vim'
    Plug 'junegunn/goyo.vim'
	Plug 'mox-mox/vim-localsearch'		  	"vim localsearch
	Plug 'ctrlpvim/ctrlp.vim'             	"fuzzy searcher
	Plug 'liuchengxu/vim-clap'			  	"interactive floating finder and dispatcher
	Plug 'dyng/ctrlsf.vim'				  	"grep search withind directory
    Plug 'majutsushi/tagbar'              	"methods viever
    Plug 'mbbill/undotree'                	"show a tree of undos
    Plug 'gcavallanti/vim-noscrollbar'    	"scrollbar-like for statusline
    "TOOLS
    Plug 'terryma/vim-multiple-cursors'   	"some multiple cursor things
    Plug 'scrooloose/nerdcommenter'       	"commenter
    Plug 'tpope/vim-abolish'              	"better renamer substituter
    Plug 'svermeulen/vim-subversive'      	"subsiitute motion
	Plug 'yggdroot/indentline'            	"indentation (characters)
    Plug 'rrethy/vim-illuminate'          	"highlightusert same words as cursor
    Plug 'wellle/targets.vim'             	"more objects to operate functions
    Plug 'jiangmiao/auto-pairs'           	"auto close brackets and parenthesis
    Plug 'luochen1990/rainbow'            	"colored brackets
    Plug 'godlygeek/tabular'              	"text aligner
    Plug 'haya14busa/incsearch.vim'
    Plug 'mattesgroeger/vim-bookmarks'    	"bookmarks per line
    Plug 'kana/vim-fakeclip'              	"better clipboard
    "GIT
    Plug 'airblade/vim-gitgutter'         	"show differences (GIT)
    Plug 'whiteinge/diffconflicts'
    Plug 'tpope/vim-fugitive'             	"git wrapper
    "BUILD
	Plug 'sakhnik/nvim-gdb'               	"GDB, LLVM wrapper
	Plug 'puremourning/vimspector'		  	"VIM DEBUGGER
	" Plug 'strottos/vim-padre', { 'dir': '~/.config/nvim/plugged/vim-padre', 'do': 'make' }
    "OTHER
	Plug 'wakatime/vim-wakatime'		  	"coding time tracker plugin
	Plug 'duggiefresh/vim-easydir'        	"create new files and folders easily
    Plug 'wincent/terminus'               	"integration with terminal functioalities
    Plug 'othree/xml.vim'
    Plug 'reedes/vim-pencil'
	Plug 'tpope/vim-markdown'
	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
    Plug 'lervag/vimtex'				  " LATEX for vim
call plug#end()

let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'

syntax on
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

let &t_SI = "\e[6 q"
let &t_EI = "\e[3 q"
let mapleader = "\<Space>"

set nocompatible
set hidden
set encoding=utf8
set guifont=Monoisome\ 12
set t_Co=256
set laststatus=2
set clipboard+=unnamedplus              " system clipboard
set viminfo=""
set noswapfile
set nobackup
set nowritebackup
set autoread
set mouse=a                             "let vim mouse scroll
set sidescroll=1
set scrollopt+=hor
set showbreak=↪\
set ruler
set showcmd                             " display incomplete commands
set showmode                            " display current modes<Paste>
set number                              " show numbers
set relativenumber
set display+=lastline
set shiftround
set hlsearch
set incsearch
set ignorecase
set smartcase

"folding things...
set foldmethod=indent
set foldnestmax=10
set foldlevel=2
set nofoldenable

"tab settings
function! UseTabs()
  set tabstop=4     " Size of a hard tabstop (ts).
  set shiftwidth=4  " Size of an indentation (sw).
  set noexpandtab   " Always uses tabs instead of space characters (noet).
  set autoindent    " Copy indent from current line when starting a new line (ai).
  set list lcs=tab:\|\                    " show line indentation when tabs
endfunction
function! UseSpaces()
  set tabstop=4     " Size of a hard tabstop (ts).
  set shiftwidth=4  " Size of an indentation (sw).
  set expandtab     " Always uses spaces instead of tab characters (et).
  set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  set autoindent    " Copy indent from current line when starting a new line.
  set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
  set list lcs=tab:\|\                    " show line indentation when tabs
  :retab
endfunction
call UseSpaces()

set completeopt=longest,menuone,preview
set wildmenu                            " show a navigable menu for tab completion
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class,*.so,*.zip,*.a,*/tmp/*
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set backspace=indent,eol,start          " make that backspace key work the way it should
set whichwrap+=<,>,h,l
set listchars=extends:›,precedes:‹,nbsp:␣,trail:·,tab:→\ ,eol:¬
set iskeyword-=_,.,=,-,:,               " specify what e word is

set scrolloff=10                        " Leave 10 lines of buffer when scrolling
set sidescrolloff=10                    " Leave 10 characters of horizontal buffer when scrolling
set cursorline
set cursorcolumn                        " column before numbers
set signcolumn="yes"



" === WHERE YOU LEFT ===""
"go to last position you were editing
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview



" === GOYO ==="
function! s:goyo_enter()
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    :SoftPencil
    set noshowmode
    set nonumber
endfunction
function! s:goyo_leave()
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    :NoPencil
    set showmode
    set number
    silent! call s:highlightuser()
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
noremap <C-g>  :Goyo<CR>
let g:goyo_width = 90


" === SEARCH SETTINGS === "
let g:better_whitespace_enabled=1
let g:incsearch#auto_nohlsearch = 1
map / <Plug>(incsearch-forward)
nmap <leader>/ <Plug>localsearch_toggle
nnoremap * *``
"substitute normal
"nnoremap <silent> + :%s/\<<C-r><C-w>\>//g<Left><Left>
"substitute with subversive + abolish
nmap s <plug>(SubversiveSubstituteRangeConfirm)
nmap + <plug>(SubversiveSubstituteWordRangeConfirm)



" === FILEMANAGER === "
"nerdtree
noremap <C-t>  :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1                "automatically clone nerd tre after open
let NERDTreeShowHidden=1
let g:NERDTreeMinimalUI = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
au VimEnter * NERDTreeRefreshRoot
"nnn
let g:nnn#set_default_mappings = 0
function! s:layout()
  let buf = nvim_create_buf(v:false, v:true)
  let width = float2nr(&columns/1.5)
  let distwidth = float2nr((&columns/2)-(width/2))
  let height = float2nr(&lines/1.5)
  let distheight = float2nr((&lines/2)-(height/2))
  let opts = {
        \ 'relative': 'editor',
        \ 'row': distheight,
        \ 'col': distwidth,
        \ 'width': width,
        \ 'height': height
        \ }
  call nvim_open_win(buf, v:true, opts)
endfunction
let g:nnn#layout = 'call ' . string(function('<SID>layout')) . '()'
nnoremap <leader>s :NnnPicker '%:p:h'<CR>
"tree
nnoremap <silent><C-f> :<C-u>Tree -columns=mark:git:indent:icon:filename:size
      \ -split=vertical
      \ -direction=topleft
      \ -winwidth=40
      \ -listed
      \ `expand('%:p:h')`<CR>
call tree#custom#option('_', {
      \ 'root_marker': '',
      \ })
autocmd FileType tree call s:set_tree()
func! s:set_tree() abort
    nnoremap <silent><buffer><expr> > tree#action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> * tree#action('toggle_select_all')
    nnoremap <silent><buffer><expr> s tree#action('drop', 'split')
    nnoremap <silent><buffer><expr> <CR> tree#action('drop')
    nnoremap <silent><buffer><expr> <Tab> tree#action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> <C-l> tree#action('redraw')
    nnoremap <silent><buffer><expr> <C-g> tree#action('print')
    nnoremap <silent><buffer><expr> E tree#action('open', 'vsplit')
    nnoremap <silent><buffer><expr> o tree#action('open_or_close_tree')
    nnoremap <silent><buffer><expr> R tree#action('open_tree_recursive')
    nnoremap <silent><buffer><expr> r tree#action('rename')
    nnoremap <silent><buffer><expr> x tree#action('execute_system')
    nnoremap <silent><buffer><expr> N tree#action('new_file')
    nnoremap <silent><buffer><expr> h tree#action('cd', ['..'])
    nnoremap <silent><buffer><expr> cd tree#action('cd', '.')
    nnoremap <silent><buffer><expr> \ tree#action('cd', getcwd())
    nnoremap <silent><buffer><expr> ~ tree#action('cd')
    nnoremap <silent><buffer><expr> l tree#action('open')
    nnoremap <silent><buffer><expr> yy tree#action('yank_path')
endf



" === OUTLINE BAR === "
"tagbar
noremap <leader>t :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_sort = 0
" autocmd FileType cpp silent! :call tagbar#autoopen(0)



" === INDENTATION LINES === "
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 236
let g:indentLine_setConceal = 2
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_concealcursor = ""



" === EASY MOTION === "
nnoremap <buffer><CR> <Plug>(easymotion-overwin-w)
hi EasyMotionTarget ctermfg=15 cterm=bold,underline
hi link EasyMotionTarget2First EasyMotionTarget
hi EasyMotionTarget2Second ctermfg=2 cterm=underline



" === WORKSPACE === "
" ctrlspace
set showtabline=0
nnoremap <f1> :CtrlSpaceSaveWorkspace<CR>
let g:CtrlSpaceDefaultMappingKey = "<C-space> "
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
" let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
" let g:CtrlSpaceSaveWorkspaceOnExit = 1
hi link CtrlSpaceNormal   Normal
hi link CtrlSpaceSelected PMenu
hi link CtrlSpaceSearch   Search
hi link CtrlSpaceStatus   StatusLine
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
let g:CtrlSpaceSymbols = { "File": "◯", "CTab": "▣", "Tabs": "▢" }
let g:CtrlSpaceUseArrowsInTerm = 1



" === CTRLP === "
let g:ctrlp_map = '<leader><leader>'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']



" === CTRLF === "
nmap     <leader>f <Plug>CtrlSFPrompt



" === FLOAT-TERM === "
noremap  <silent> <Insert>           :FloatermToggle<CR>i
noremap! <silent> <Insert>           <Esc>:FloatermToggle<CR>i
tnoremap <silent> <Insert>           <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_position = 'center'
let g:floaterm_width = float2nr(&columns/1.5)
let g:floaterm_height = float2nr(winheight(0)/1.5)



" === NEOGDB === "
let g:gdb_keymap_continue = '<f8>'
let g:gdb_keymap_next = '<f10>'
let g:gdb_keymap_step = '<f11>'
" Usually, F23 is just Shift+F11
let g:gdb_keymap_finish = '<f23>'
let g:gdb_keymap_toggle_break = '<f9>'
" Usually, F33 is just Ctrl+F9
let g:gdb_keymap_toggle_break_all = '<f33>'
let g:gdb_keymap_frame_up = '<c-n>'
let g:gdb_keymap_frame_down = '<c-p>'
" Usually, F21 is just Shift+F9
let g:gdb_keymap_clear_break = '<f21>'
" Usually, F17 is just Shift+F5
let g:gdb_keymap_debug_stop = '<f17>'



" === MOCELINES === "
nmap <C-A-Down> <Plug>MoveLineDown
nmap <C-A-Up> <Plug>MoveLineUp
vmap <C-A-Down> <Plug>MoveBlockDown
vmap <C-A-Up> <Plug>MoveBlockUp



" === NAVIGATION === "
"navigation panes
imap <C-Pagedown> <C-O>:CtrlSpaceGoDown<CR>
imap <C-Pageup> <C-O>:CtrlSpaceGoUp<CR>
map <C-Pagedown> :CtrlSpaceGoDown<CR>
map <C-Pageup> :CtrlSpaceGoUp<CR>
map <C-M-Pagedown> :tabn<CR>
map <C-M-Pageup> :tabp<CR>
map <leader>v :vnew<CR>
map <leader>b :new<CR>
map <leader>n :enew<CR>
nmap - :e #<cr>
map <C-Up> <C-k>
map <C-Down> <C-j>
map <C-Left> <C-h>
map <C-Right> <C-l>
"move vertically on soft lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
"move horizontally
map <home> ^
map <end> $
"exit
cmap Q quitall
cmap W write



" === COMFORTABLE SCROLLING === "
let g:comfortable_motion_no_default_key_mappings = 1
map <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
imap <ScrollWheelDown> <C-O><ScrollWheelDown>
map <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
imap <ScrollWheelUp> <C-O><ScrollWheelUp>
let g:comfortable_motion_impulse_multiplier = 2
map <silent> <Pagedown> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0))<CR>
imap <Pagedown> <C-O><Pagedown>
map <silent> <Pageup>   :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * -winheight(0))<CR>
imap <Pageup> <C-O><Pageup>
let g:comfortable_motion_friction = 60.0
let g:comfortable_motion_air_drag = 4.0
let g:comfortable_motion_interval = 1000.0 / 60



" ===RUN === "
" asyncrun
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
let g:asyncrun_open = 8
"cmakerun
map <C-F7> <ESC><Esc>:!cmake --build build/ --target<CR>
map <C-F8> <ESC><Esc>:!rm -rf build/*<CR>:!cmake -H. -Bbuild -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug<CR>
map <C-F9> <ESC><Esc>:!rm -rf build/*<CR>:!cmake -H. -Bbuild -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=FastDebug<CR>
map <F7> <ESC><Esc>:!ninja -C build<CR>
map <F8> <ESC><Esc>:!rm -rf build/*<CR>:!cmake -H. -Bbuild -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug -GNinja<CR>
map <F9> <ESC><Esc>:!rm -rf build/*<CR>:!cmake -H. -Bbuild -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=FastDebug -GNinja<CR>




" === ALE === "
let g:ale_sign_error = '×'
let g:ale_sign_warning = '!'
highlight ALEWarning ctermbg=0 ctermfg=220 cterm=bold
highlight ALEWarningSign ctermbg=220 ctermfg=231 cterm=bold
highlight ALEError ctermbg=0 ctermfg=196 cterm=bold
highlight ALEErrorSign ctermbg=196 ctermfg=231 cterm=bold
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'go': ['~/.go/bin/gopls'],
    \ 'nim': ['~/.nimble/bin/nimlsp'],
	\ 'cpp': ['clangtidy'],
    \ 'python': ['/usr/local/bin/pyls']
	\ }
let g:ale_fixers = {
	\ 'cpp': ['clang-format'],
	\ }
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1
" let g:ale_fix_on_save = 1
nmap <F10> <Plug>(ale_fix)
au TabLeave * silent! <Plug>(ale_fix)
au BufLeave * silent! <Plug>(ale_fix)



" === LANGUAGE SERVER === "
let g:LanguageClient_autoStart = 1
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_hoverPreview = "Never"
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'go': ['~/.go/bin/gopls'],
    \ 'nim': ['~/.nimble/bin/nimlsp'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'c': ['clangd', '-compile-commands-dir=' . getcwd() . '/build'],
    \ 'cpp': ['clangd', '-compile-commands-dir=' . getcwd() . '/build'],
    \ 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
    \       using LanguageServer;
    \       using Pkg;
    \       import StaticLint;
    \       import SymbolServer;
    \       env_path = dirname(Pkg.Types.Context().env.project_file);
    \       debug = false;
    \       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
    \       server.runlinter = true;
    \       run(server);']
    \ }
    " \ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
nnoremap <S-tab> :call LanguageClient_textDocument_definition()<cr>
nnoremap <tab> :call LanguageClient#textDocument_hover()<CR>
nnoremap <F2> :call LanguageClient_textDocument_rename()<cr>
nnoremap <bs> :call LanguageClient_textDocument_rename()<cr>
" markdown
let g:markdown_syntax_conceal = 0



" === DEOPLETE === "
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" let g:deoplete#sources._ = ['buffer', 'member', 'tag', 'file', 'omni', 'ultisnips']
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)
call deoplete#custom#var('tabnine',{'line_limit': 500,'max_num_results': 5})
call deoplete#custom#option('auto_complete_delay', 200)
"autocomplete popup - nvigation keys and enter to select
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
"floating window
let g:float_preview#docked = 0
let g:float_preview#auto_close = 1
function! DisableExtras()
  call nvim_win_set_option(g:float_preview#win, 'number', v:false)
  call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
  call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
endfunction
autocmd User FloatPreviewWinOpen call DisableExtras()



" === ULTISNIPS === "
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<C-tab>"



" === COMMENTER === "
let g:NERDCompactSexyComs = 1
let g:NERDSpaceDelims = 1
map <silent> # <plug>NERDCommenterToggle



" === GIT GUTTER & FUGITIVE === "
highlight GitGutterAdd    ctermfg=2 ctermbg=1
highlight GitGutterChange ctermfg=3 ctermbg=2
highlight GitGutterDelete ctermfg=1 ctermbg=3


" === VIMTEX === "
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'



" === OTHER SHORTCUTS === "
"undo and undotree
nnoremap U :redo<CR>
nnoremap <C-U> :UndotreeToggle<CR> :UndotreeFocus<CR>
"rainbow brackets
let g:rainbow_active = 1
"bookmarks
let g:bookmark_auto_save_file = $HOME .'/.config/nvim/bookmarks'
"semicolons
autocmd FileType cpp nmap <silent> , <Plug>(cosco-commaOrSemiColon)



" === AUTOSAVE === "
autocmd FileType cpp let b:auto_save = 1
autocmd FileType hpp let b:auto_save = 1
autocmd FileType h let b:auto_save = 1
autocmd FileType cmake let b:auto_save = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost", "FocusGained"]
let g:auto_save_write_all_buffers = 1
" let g:auto_save_presave_hook = 'call AbortIfNotGitDirectory()'
" function! AbortIfNotGitDirectory()
  " if ...
    " let g:auto_save_abort = 0
  " else
    " let g:auto_save_abort = 1
  " endif
" endfunction



" === FOLDING === "
if has('folding')
	set foldenable
	set foldmethod=syntax
	set foldlevelstart=99
	set foldtext=FoldText()
endif
function! FoldText()
	" Get first non-blank line
	let fs = v:foldstart
	while getline(fs) =~? '^\s*$' | let fs = nextnonblank(fs + 1)
	endwhile
	if fs > v:foldend
		let line = getline(v:foldstart)
	else
		let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
	endif

	let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
	let foldSize = 1 + v:foldend - v:foldstart
	let foldSizeStr = ' ' . foldSize . ' lines '
	let foldLevelStr = repeat('+--', v:foldlevel)
	let lineCount = line('$')
	let foldPercentage = printf('[%.1f', (foldSize*1.0)/lineCount*100) . '%] '
	let expansionString = repeat('.', w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
	return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endfunction



" === HIGHLIGHTS === "
function! s:highlightuser()
    "background
    highlight Normal ctermbg=0
	"visual select
    highlight Visual ctermbg=236 cterm=bold
	"cursor
    highlight Search ctermfg=231 ctermbg=9
    highlight CursorLine ctermbg=16 cterm=bold
    highlight CursorColumn ctermbg=16 cterm=bold
    highlight Cursor ctermfg=7 ctermbg=7
    "similar words
    highlight illuminatedWord ctermbg=16 cterm=bold,underline
    "squicky lines "~" hide
    highlight EndOfBuffer ctermfg=0 ctermbg=0
    "splits and number backgrounds
    highlight VertSplit ctermbg=black ctermfg=16    "vertical split colorscheme
    highlight foldcolumn ctermbg=0                 " colum before numbers
    highlight LineNr ctermbg=0 ctermfg=1
    highlight CursorLineNR ctermbg=16 ctermfg=1 cterm=bold
    "special characters of endline
    highlight NonText ctermfg=236
    "completion menu
    highlight Pmenu ctermbg=16 ctermfg=231
    highlight PmenuSel ctermbg=0 ctermfg=9 cterm=bold
    highlight PmenuSbar ctermbg=0
    highlight PmenuThumb ctermbg=0
    "other
    highlight MatchParen ctermfg=231 ctermbg=1 cterm=bold
endfunction



" === FOCUS === "
"change color on focus lost
function! s:beactive()
    highlight CursorLine ctermbg=16
    highlight CursorColumn ctermbg=16
    highlight CursorLineNR ctermbg=16
    " set number
    highlight LineNr ctermfg=1
    highlight CursorLineNR ctermfg=1
    highlight NonText ctermfg=236
    "syntax on
endfunction
function! s:bepassive()
    highlight CursorLine ctermbg=NONE
    highlight CursorColumn ctermbg=NONE
    highlight CursorLineNR ctermbg=NONE
    " set nonumber
    highlight LineNr ctermfg=0
    highlight CursorLineNR ctermfg=0
    highlight NonText ctermfg=0
    "syntax off
endfunction
au FocusLost * silent! call s:bepassive()
au FocusGained * silent! call s:beactive()



" === AIRLINE THEME === "
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
let g:airline#extensions#tabline#enabled = 1 " set tabs/buffers in the top
let g:airline_section_z=airline#section#create(['%{noscrollbar#statusline(15,"─","■")} ']) "Ø ×⊙
let g:airline_exclude_preview = 1



" === SYNTAX === "
function! s:syntaxuser()
    highlight Normal ctermfg=231 ctermbg=16 cterm=NONE
    highlight Boolean ctermfg=219 ctermbg=NONE cterm=NONE
    highlight Character ctermfg=219 ctermbg=NONE cterm=NONE
    highlight Comment ctermfg=103 ctermbg=NONE cterm=NONE
    highlight Conditional ctermfg=203 ctermbg=NONE cterm=NONE
    highlight Constant ctermfg=NONE ctermbg=NONE cterm=NONE
    highlight Define ctermfg=203 ctermbg=NONE cterm=NONE
    highlight DiffAdd ctermfg=231 ctermbg=64 cterm=bold
    highlight DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE
    highlight DiffChange ctermfg=231 ctermbg=23 cterm=NONE
    highlight DiffText ctermfg=231 ctermbg=24 cterm=bold
    highlight ErrorMsg ctermfg=231 ctermbg=203 cterm=NONE
    highlight WarningMsg ctermfg=231 ctermbg=203 cterm=NONE
    highlight Float ctermfg=219 ctermbg=NONE cterm=NONE
    highlight Function ctermfg=203 ctermbg=NONE cterm=NONE
    highlight Identifier ctermfg=51 ctermbg=NONE cterm=NONE
    highlight Keyword ctermfg=203 ctermbg=NONE cterm=NONE
    highlight Label ctermfg=111 ctermbg=NONE cterm=NONE
    highlight NonText ctermfg=60 ctermbg=17 cterm=NONE
    highlight Number ctermfg=219 ctermbg=NONE cterm=NONE
    highlight Operator ctermfg=203 ctermbg=NONE cterm=NONE
    highlight PreProc ctermfg=203 ctermbg=NONE cterm=NONE
    highlight Special ctermfg=231 ctermbg=NONE cterm=NONE
    highlight SpecialKey ctermfg=60 ctermbg=23 cterm=NONE
    highlight Statement ctermfg=203 ctermbg=NONE cterm=NONE
    highlight StorageClass ctermfg=51 ctermbg=NONE cterm=NONE
    highlight String ctermfg=111 ctermbg=NONE cterm=NONE
    highlight Tag ctermfg=203 ctermbg=NONE cterm=NONE
    highlight Title ctermfg=231 ctermbg=NONE cterm=bold
    highlight Todo ctermfg=103 ctermbg=NONE cterm=inverse,bold
    highlight Type ctermfg=NONE ctermbg=NONE cterm=NONE
    highlight Underlined ctermfg=NONE ctermbg=NONE cterm=underline
endfunction



" === THEME === "
colorscheme one
call s:highlightuser()



" === REMOVE HABITS === "
nnoremap d "_d
vnoremap d "_d
map <S-Up> <Nop>
map <S-Down> <Nop>
