call plug#begin()
    "SYNTAX
    Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
    Plug 'ncm2/float-preview.nvim'
    Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
    Plug 'sheerun/vim-polyglot'           "A collection of language packs for Vim
    Plug 'w0rp/ale'                       "syntax checker for vim
    Plug 'SirVer/ultisnips'               "snipets engine
    Plug 'honza/vim-snippets'             "snippets collection
    Plug 'Chiel92/vim-autoformat'         "code formatter
    Plug 'ntpeters/vim-better-whitespace' "whitespace detection
    Plug 'rhysd/vim-grammarous'           "gramar checker
    Plug 'lfilho/cosco.vim'               "add semicolon or comma n the end
    Plug 'lilydjwg/colorizer'             "show hex colors
    "WORKSPACE
    Plug 'vim-ctrlspace/vim-ctrlspace'    "a better workspace manager
    Plug 'benmills/vimux'                 "run shell comands in a tmux pane
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'nikvdp/neomux'                  "a wanabe tmux terminal replacement
    Plug 'skywind3000/asyncrun.vim' 	  "run commands
    Plug 'ingolemo/vim-bufferclose'
    Plug '907th/vim-auto-save'            "vim autsave plugin
    Plug 'editorconfig/editorconfig-vim'  "EDITOR-CONFIG settings
    "THEME
    Plug 'vim-airline/vim-airline-themes'
    Plug 'vim-airline/vim-airline'
    Plug 'edkolev/promptline.vim'
    Plug 'powerline/fonts'                "patched powerline-fonts
    Plug 'rakr/vim-one'                   "Atom ONE theme
    "NAVIGATION
    Plug 'easymotion/vim-easymotion'      "jump to any location
    Plug 'matze/vim-move'                 "move lines with alt-arrow
    Plug 'farmergreg/vim-lastplace'       "remember last cursor position
    Plug 'yuttie/comfortable-motion.vim'  "comfortable scroll
    Plug 'tpope/vim-repeat'               " '.' for better repeat functioalities
    "VIEWS
    Plug 'scrooloose/nerdtree'            "side-bar file manager
    Plug 'ryanoasis/vim-devicons'         "icons for nerdtre
    Plug 'mcchrish/nnn.vim'
    Plug 'junegunn/goyo.vim'
    Plug 'ctrlpvim/ctrlp.vim'             "fuzzy searcher
    Plug 'majutsushi/tagbar'              "methods viever
    Plug 'mbbill/undotree'                "show a tree of undos
    Plug 'gcavallanti/vim-noscrollbar'    "scrollbar-like for statusline
    "TOOLS
    Plug 'terryma/vim-multiple-cursors'   "some multiple cursor things
    Plug 'scrooloose/nerdcommenter'       "commenter
    Plug 'tpope/vim-abolish'              "better renamer substituter
    Plug 'svermeulen/vim-subversive'      "subsiitute motion
    Plug 'yggdroot/indentline'            "indentation (characters)
    Plug 'rrethy/vim-illuminate'          "highlightusert same words as cursor
    Plug 'wellle/targets.vim'             "more objects to operate functions
    Plug 'jiangmiao/auto-pairs'           "auto close brackets and parenthesis
    Plug 'luochen1990/rainbow'            "colored brackets
    Plug 'godlygeek/tabular'              "text aligner
    Plug 'AndrewRadev/splitjoin.vim'      "singe-multi line function converter
    Plug 'haya14busa/incsearch.vim'
    Plug 'mattesgroeger/vim-bookmarks'    "bookmarks per line
    Plug 'kana/vim-fakeclip'              "better clipboard
    "GIT
    Plug 'airblade/vim-gitgutter'         "show differences (GIT)
    Plug 'tpope/vim-fugitive'             "git wrapper
    "BUILD
    Plug 'vhdirk/vim-cmake'               "CMAKE integration
    Plug 'sakhnik/nvim-gdb'               "GDB, LLVM wrapper
    Plug 'metakirby5/codi.vim'            "interactive scratchpad (like jupyter of sort)
    "OTHER
    Plug 'duggiefresh/vim-easydir'        "create new files and folders easily
    Plug 'wincent/terminus'               "integration with terminal functioalities
    Plug 'othree/xml.vim'
    Plug 'reedes/vim-pencil'
    Plug 'plasticboy/vim-markdown'
    Plug 'lervag/vimtex'
    Plug 'junegunn/fzf.vim'
call plug#end()

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
"au BufWrite * :Autoformat



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
"viaual search
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  " Use this line instead of the above to match matches spanning across lines
  "let @/ = '\V' . substitute(escape(@@, '\'), '\_s\+', '\\_s\\+', 'g')
  call histadd('/', substitute(@/, '[?/]', '\="\\%d".char2nr(submatch(0))', 'g'))
  let @@ = temp
endfunction
" nnoremap <silent> + :%s/\<<C-r><C-w>\>//g<Left><Left>
map <silent> ' :<C-u>call <SID>VSetSearch()<CR>/<CR>
"subversive + abolish
nmap + <plug>(SubversiveSubvertWordRange)



" === FILEMANAGER === "
"nerdtree
noremap <C-t>  :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1                "automatically clone nerd tre after open
let g:NERDTreeMinimalUI = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
au VimEnter * NERDTreeRefreshRoot
"nnn
let g:nnn#set_default_mappings = 0
nnoremap <leader>s :NnnPicker '%:p:h'<CR>



" === OUTLINE BAR === "
"tagbar
noremap <leader>t :TagbarToggle<CR>
let g:tagbar_compact = 1
let g:tagbar_sort = 0
autocmd FileType cpp silent! :call tagbar#autoopen(0)



" === INDENTATION LINES === "
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_term = 236



" === EASY MOTION === "
map <C-m> <Plug>(easymotion-overwin-w)
hi EasyMotionTarget ctermfg=15 cterm=bold,underline
hi link EasyMotionTarget2First EasyMotionTarget
hi EasyMotionTarget2Second ctermfg=2 cterm=underline



" === WORKSPACE === "
" ctrlspace
set showtabline=0
nnoremap <C-s> :CtrlSpaceSaveWorkspace<CR>
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



" ===RUN === "
" asyncrun
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
let g:asyncrun_open = 8
"cmakerun
map <F7> <ESC><Esc>:!cmake --build build/ --target && bin/./main<CR>
imap <F7> <ESC><Esc>:!cmake --build build/ --target && bin/./main<CR>
map <F8> <ESC><Esc>:!rm -rf build/*<CR>:!cmake -H. -Bbuild<CR>
imap <F8> <ESC><Esc>:!rm -rf build/*<CR>:!cmake -H. -Bbuild<CR>
map <F9> :call asyncrun#quickfix_toggle(6)<cr>
" map <F7> <ESC><Esc>:make && bin/./main<CR>
" nvimux
nnoremap <leader><cr> :Neomux<cr>



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
"save
cmap w!! %!sudo tee > /dev/null %



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



" === ALE === "
let g:ale_sign_error = '×'
let g:ale_sign_warning = '!'
highlight ALEWarning ctermbg=0 ctermfg=220 cterm=bold
highlight ALEWarningSign ctermbg=220 ctermfg=231 cterm=bold
highlight ALEError ctermbg=0 ctermfg=196 cterm=bold
highlight ALEErrorSign ctermbg=196 ctermfg=231 cterm=bold
let g:airline#extensions#ale#enabled = 1



" === LANGUAGE SERVER === "
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'go': ['~/.go/bin/gopls'],
    \ 'cpp': ['clangd'],
    \ 'python': ['/usr/local/bin/pyls'],
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
nnoremap <leader>ld :call LanguageClient_textDocument_definition()<cr>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>lr :call LanguageClient_textDocument_rename()<cr>



" === DEOPLETE === "
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
" let g:deoplete#sources._ = ['buffer', 'member', 'tag', 'file', 'omni', 'ultisnips']
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 2)
call deoplete#custom#var('tabnine',{'line_limit': 500,'max_num_results': 5})
"autocomplete popup - nvigation keys and enter to select
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
"floating window
let g:float_preview#docked = 0
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
"autosave settings
autocmd FileType cpp silent! :AutoSaveToggle
autocmd FileType hpp silent! :AutoSaveToggle
autocmd FileType h silent! :AutoSaveToggle
autocmd FileType cmake silent! :AutoSaveToggle
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost", "FocusGained"]
let g:auto_save_write_all_buffers = 1



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
    highlight Cursor ctermfg=8 ctermbg=231
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
    set number
    highlight LineNr ctermfg=1
    highlight CursorLineNR ctermfg=1
    highlight NonText ctermfg=236
    "syntax on
endfunction
function! s:bepassive()
    highlight CursorLine ctermbg=NONE
    highlight CursorColumn ctermbg=NONE
    highlight CursorLineNR ctermbg=NONE
    set nonumber
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
map <S-Up> <Nop>
map <S-Down> <Nop>
