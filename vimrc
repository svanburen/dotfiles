" dot vimrc

" {{{ Basic things

syntax enable

" Leader is space key
let g:mapleader = "\<Space>"

" LocalLeader is the comma key
let g:maplocalleader = ","

" Install vim-plug if it doesn't exist.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>pg :PlugUpgrade<cr>
nnoremap <leader>ps :PlugStatus<cr>
nnoremap <leader>pu :PlugUpdate<cr>

" }}}

" {{{ Plugins

scriptencoding utf-8
call plug#begin('~/.vim/plugged')

" {{{ UI

Plug 'mhinz/vim-startify'
  let g:startify_bookmarks = [ {'v': '~/.vimrc'}, {'f': '~/.config/fish/config.fish'} ]
  " use utf-8 for fortune rather than ascii
  let g:startify_fortune_use_unicode = 1
  " update startify while vim is running
  let g:startify_update_oldfiles = 1
  " Don't change to the directory of a file when using startify
  let g:startify_change_to_dir = 0

Plug 'itchyny/lightline.vim'
  let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ }
    \ }

" disable netrw_
let loaded_netrwPlugin = 1
Plug 'justinmk/vim-dirvish'
Plug 'justinmk/vim-gtfo'
nnoremap gx :call netrw#BrowseX(expand((exists("g:netrw_gx")? g:netrw_gx : '<cfile>')),netrw#CheckIfRemote())<cr>

" Shows mappings, registers, etc
Plug 'junegunn/vim-peekaboo'

" Better whitespace highlighting / provides :StripWhitespace
Plug 'ntpeters/vim-better-whitespace'
  nmap <silent> <leader>sw :StripWhitespace<cr>

" }}}

" {{{ Git

Plug 'airblade/vim-gitgutter'
  let g:gitgutter_grep = 'rg'

Plug 'junegunn/gv.vim', { 'on': ['GV'] }
  nmap <leader>gv :GV<cr>

Plug 'tpope/vim-fugitive'
  nmap <leader>gd :Gdiff<cr>
  " Bring up git status vertically
  nmap <silent> <leader>gs :vertical Git<cr>

" Extends vim-fugitive for GitHub
Plug 'tpope/vim-rhubarb'

" Enhances git commit writing
Plug 'rhysd/committia.vim'

" github filetype
Plug 'jez/vim-github-hub'

" reveal last commit message (default binding: <Leader>gm)
Plug 'rhysd/git-messenger.vim'

" }}}

" {{{ Languages / Filetype

" fish
" There are some more up to date forks
" This ruined filetype detection - ensure that we've got a ftplugin/fish.vim
" or this might do the same in the future
Plug 'dag/vim-fish', { 'for': 'fish' }

" yaml
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }

" nim
Plug 'zah/nim.vim', { 'for': 'nim' }

" elixir
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }

" chucK
Plug 'wilsaj/chuck.vim', { 'for': 'chuck' }

" Elm
Plug 'elmcast/elm-vim', { 'for': 'elm' }

" HTML5
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'mattn/emmet-vim'

" Javascript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maxmellon/vim-jsx-pretty', { 'for': [ 'typescriptreact', 'javascriptreact' ] }

" typescript
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescriptreact'] }

" Vue.js
" TODO: Remove once I stop using Vue
Plug 'posva/vim-vue', { 'for': 'vue' }

" GraphQL
Plug 'jparise/vim-graphql', { 'for': 'graphql' }

" JSON
Plug 'elzr/vim-json', { 'for': 'json' }
  " Don't really care for the concealing
  let g:vim_json_syntax_conceal = 0

" Dockerfile
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }

" gitignore
" Causes some problems with UltiSnips
" Plug 'gisphm/vim-gitignore'

" Go
" make sure to do :GoInstallBinaries on new systems
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  let g:go_fmt_command = 'goimports'

" Brewfile
Plug 'bfontaine/Brewfile.vim'

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  let g:rustfmt_autosave = 1

Plug 'mhinz/vim-crates', { 'for': 'rust' }

" Crystal
Plug 'rhysd/vim-crystal', { 'for': 'crystal' }

" Gist
Plug 'mattn/gist-vim', { 'for': 'gist' }

" nginx
Plug 'fatih/vim-nginx', { 'for': 'nginx' }

" for tmux.conf files
Plug 'tmux-plugins/vim-tmux', { 'for': 'tmux' }
" Plug 'keith/tmux.vim'

" TOML
Plug 'cespare/vim-toml', { 'for': 'toml' }

" Terraform
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }

" Python
" Syntax
Plug 'vim-python/python-syntax', { 'for': 'python' }
  " I think this slows things down
  let g:python_highlight_all = 1

" Quickly open python modules
Plug 'sloria/vim-ped', { 'for': 'python', 'on': 'Ped' }

" Indent
" Is this useful now that I'm using black?
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

Plug 'alfredodeza/pytest.vim', { 'for': 'python', 'on': 'Pytest' }
Plug 'alfredodeza/coveragepy.vim', { 'for': 'python', 'on': 'Coveragepy' }

" Clojure
Plug 'tpope/vim-fireplace', { 'for' : 'clojure' }
Plug 'tpope/vim-salve', { 'for' : 'clojure' }
Plug 'Olical/conjure', { 'for': 'clojure', 'tag': 'v2.1.2', 'do': 'bin/compile' }
  let g:conjure_log_direction = "horizontal"
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }
Plug 'jiangmiao/auto-pairs'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" }}}

" {{{ Completion

" if has('nvim')
"   Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"   let g:deoplete#enable_at_startup = 1
" endif

" }}}

" {{{ Colorschemes

Plug 'morhetz/gruvbox'
  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_italic = 1

" }}}

" {{{ fzf

Plug 'junegunn/fzf', { 'dir' : '~/.fzf', 'do' : './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
  omap <leader><tab> <plug>(fzf-maps-o)
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)

  nnoremap <leader><Enter> :GFiles<cr>
  nnoremap <leader>f :Files<cr>
  nnoremap <leader>gf :GFiles?<cr>
  " nnoremap ; :Buffers<cr>
  nnoremap <leader><leader> :Buffers<cr>
  nnoremap <leader>? :History<CR>
  " mnemonic for command history
  nnoremap <leader>ch :History:<CR>
  nnoremap <leader>sh :History/<CR>
  nnoremap <leader>m :Marks<cr>
  nnoremap <leader>; :BLines<CR>
  nnoremap <leader>W :Windows<CR>
  nnoremap <leader>tg :Tags<cr>
  nnoremap <leader>gc :Commits!<cr>

  " Try this out?
  " imap <C-x><C-l> <plug>(fzf-complete-line)

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --smart-case --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
    \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
    \   <bang>0)
  nnoremap <leader>se :Rg!<cr>
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

  " command! -bang Directories call fzf#run(fzf#wrap({'source': 'find * -type d'}))

Plug 'alok/notational-fzf-vim'
  let g:nv_search_paths = ['~/nv']
  nnoremap <silent> <c-s> :NV<cr>

" }}}

" {{{ Linters / Syntax / Formatting

" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 0
" For linting
Plug 'w0rp/ale'
  let g:ale_sign_error = '→'
  let g:ale_sign_warning = '→'
  let g:ale_sign_info = '→'
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%] %s'
  " let g:ale_python_auto_pipenv = 1
  " let g:ale_lint_on_text_changed = 'normal'
  " let g:ale_lint_on_insert_leave = 1
  let g:ale_set_balloons = 1
  " Set this variable to 1 to fix files when you save them.
  let g:ale_fix_on_save = 1
  " don't need this as we're setting VIRTUAL_ENV using direnv
  " https://github.com/w0rp/ale/issues/2021#issuecomment-433325140
  let g:ale_virtualenv_dir_names = []
  " note that python files have their ALE configuration in ftplugin/python.vim
  " Without this, eslint complains about things that prettier fixes
  let g:ale_fixers = {
  \   '*': ['remove_trailing_lines', 'trim_whitespace'],
  \   'javascript': ['prettier', 'eslint'],
  \   'elixir': ['mix_format'],
  \   'rust': ['rustfmt'],
  \}
  let g:ale_linters = {
  \   'fish': [],
  \   'javascript': ['prettier', 'eslint'],
  \   'text': ['vale'],
  \   'markdown': ['vale', 'markdownlint'],
  \   'clojure': ['joker', 'clj-kondo'],
  \}
  nnoremap <silent> <leader>af :ALEFix<cr>
  nnoremap <C-]> :ALEGoToDefinition<cr>
  nmap <silent> [w <Plug>(ale_previous_wrap)
  nmap <silent> ]w <Plug>(ale_next_wrap)

" }}}

" {{{ Movement / Motions

" Lightweight improvement of search
Plug 'junegunn/vim-slash'
if has('timers')
  " Blink 2 times with 50ms interval
  noremap <expr> <plug>(slash-after) slash#blink(2, 50)
endif

" }}}

" {{{ Commenting

Plug 'tpope/vim-commentary'

" }}}

" {{{ Documentation

" TODO: can I ditch investigate for keywordprg?
Plug 'keith/investigate.vim'
  nnoremap <leader>? :call investigate#Investigate('n')<cr>
  nnoremap <leader>K :call investigate#Investigate('n')<cr>
  vnoremap <leader>K :call investigate#Investigate('v')<cr>
  let g:investigate_use_dash=1

" }}}

" {{{ Games

" Pong-like game
Plug 'johngrib/vim-game-code-break', { 'on': 'VimGameCodeBreak' }

" }}}

" {{{ Other

" For profiling startup time
Plug 'dstein64/vim-startuptime', { 'on': 'StartupTime' }

" Adds unix shell commands
Plug 'tpope/vim-eunuch'

" tmux / vim navigation
Plug 'christoomey/vim-tmux-navigator'
  " Disable tmux navigator when zooming the Vim pane
  let g:tmux_navigator_disable_when_zoomed = 1

" Heuristically set buffer options
" TODO: determine if not enabling this causes weird buffer options
" Plug 'tpope/vim-sleuth'

" Automatic :set paste
Plug 'ConradIrwin/vim-bracketed-paste'

" Deal with parentheses, quotes, etc.
Plug 'machakann/vim-sandwich'

" Disables arrow keys, hljk, page-up / page-down to force using more specific motions
Plug 'takac/vim-hardtime'
  " On by default
  let g:hardtime_default_on = 1
  " Remove - from the list - this is for vim-dirvish
  let g:list_of_normal_keys = ["h", "j", "k", "l", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
  let g:hardtime_timeout = 2000

" Repeat plugin maps
Plug 'tpope/vim-repeat'

" Use ^a / ^x to increment / decrement dates, times, etc.
Plug 'tpope/vim-speeddating'

" Handy bracket ( ] and [ ) mappings
Plug 'tpope/vim-unimpaired'

" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'

Plug 'tpope/vim-dispatch'
  nnoremap <leader>h :Make<cr>
Plug 'janko/vim-test'
  let test#strategy = "dispatch"
  nmap <silent> t<C-n> :TestNearest<CR>
  nmap <silent> t<C-f> :TestFile<CR>
  nmap <silent> t<C-s> :TestSuite<CR>
  nmap <silent> t<C-l> :TestLast<CR>
  nmap <silent> t<C-g> :TestVisit<CR>

" 🎄
Plug 'rhysd/vim-syntax-christmas-tree', { 'on': 'MerryChristmas' }

" }}}

call plug#end()
filetype plugin indent on

" }}}

" {{{ Settings

set termguicolors
colorscheme gruvbox
set background=light

" :set wrap to use this
set breakindent
set breakindentopt=shift:2
set showbreak=↳

" Highlight the line where the cursor is
set cursorline

" statusline current ^
" statusline not current =
" vertical empty (escaped space)
" fold: filling foldtext
" diff: deleted lines in diff
set fillchars=stl:^,stlnc:=,vert:\ ,fold:·,diff:-

" c: Auto-wrap comments using textwidth, inserting the current comment leader automatically.
" q: Allow formatting of comments with "gq".
" r: Automatically insert the current comment leader after hitting <Enter> in Insert mode.
" j: Where it makes sense, remove a comment leader when joining lines
" o: Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set formatoptions=c,q,r,j,o

" Global substitutions by default.
set gdefault

" Don't get rid of hidden buffers.
set hidden

" turn on incremental search
set incsearch
" highlight search
set hlsearch

" Show the results of a substitution in a separate preview buffer
set inccommand=split

" Ignore case while searching
set ignorecase
" ... except when capitals are used
set smartcase

" Don't redraw when using macros.
set lazyredraw

" Display invisible characters
set list
set listchars=tab:→-,eol:¬,trail:⋅

" Don't insert two spaces after punctuation with a join command.
set nojoinspaces

" Don't show the mode on the command line - it's redundant with the status line.
set noshowmode
" When doing a variety of movement commands (gg, C-D, C-U, C-G, etc.) _don't_
" move the cursor automatically to the beginning of the line
set nostartofline

" line numbers
" setting these both together means that the current line number is the actual
" line number of the file, while the other line numbers are relative.
set number
set relativenumber

" maintain an undofile for undoing actions through neovim loads
set undofile

" Show matching brackets briefly.
set showmatch

" On horizontal split, open the split below.
set splitbelow
" On veritcal split, open the split to the right.
set splitright

" Don't syntax highlight after 200 columns (for larger files).
set synmaxcol=200

" Highlight fenced code in markdown
" https://til.hashrocket.com/posts/e8915e62c0-highlight-markdown-fenced-code-syntax-in-vim
let g:markdown_fenced_languages = ['html', 'vim', 'go', 'python', 'bash=sh']

" maximum popup menu height of 20 items
set pumheight=20

" }}}

" {{{ Mappings

nnoremap ; :

nnoremap <silent> j gj
nnoremap <silent> k gk
vnoremap j gj
vnoremap k gk

" Navigate between matching brackets
nmap <tab> %

nmap <leader>/ :nohl<cr>

" For editing various configuration files
nmap <leader>eg :e $HOME/.gitconfig<cr>
" Ensure we're editing ~/.vimrc, rather than $MYVIMRC - since in neovim
" $MYVIMRC just points to a wrapper
nmap <leader>ev :e $HOME/.vimrc<cr>

nmap <leader>w :w<cr>

nmap <leader>rt :retab<cr>
nmap <leader>so :source $MYVIMRC<cr>
nmap <leader>sp :setlocal spell!<cr>

nnoremap <leader>cl :close<cr>
nnoremap <leader>ss :split<cr>
nnoremap <leader>vs :vsplit<cr>

nnoremap <silent> ]r :tabn<cr>
nnoremap <silent> [r :tabp<cr>

nnoremap <silent> <leader>tn :tabnew<cr>

" Use Q to repeat last macro, rather than going into ex mode
nnoremap Q @@

" Swap the behavior of the ^ and 0 operators
" ^ Usually goes to the first non-whitespace character, while 0 goes to the
" first column in the line. ^ is more useful, but harder to hit, so swap it
" with 0
nnoremap 0 ^
nnoremap ^ 0

" Indent the whole file and return to starting position
nnoremap g= gg=G``

" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" https://til.hashrocket.com/posts/ba2afeb453-breezy-copy-to-system-clipboard-in-vim
" copy to system clipboard
map gy "*y
" copy whole file to system clipboard
nmap gY gg"*yG

" always center the screen after any movement command
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
nnoremap <C-u> <C-u>zz

" https://bluz71.github.io/2017/05/15/vim-tips-tricks.html
nnoremap <silent> <leader>S :syntax sync fromstart<CR>

nnoremap <leader>V V`]
nnoremap <leader>cc :set cc=100<cr>
nnoremap <leader>co :set cc=""<cr>

cmap %s/ %s/\v
cmap w!! w !sudo tee % >/dev/null

inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

vmap <leader>s :s/
vmap <tab> %
vmap s :!sort<cr>
vmap u :!sort -u<cr>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

vnoremap < <gv
vnoremap > >gv

" similar to vmap but only for visual mode - NOT select mode
xnoremap < <gv
xnoremap > >gv

" }}}

" {{{ Highlights

highlight IncSearch   ctermbg=1 ctermfg=4
highlight VertSplit   ctermbg=2
highlight Visual      ctermbg=1 ctermfg=4

" }}}

" {{{ Autocommands

augroup FT
  autocmd FileType go   setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType java setlocal expandtab tabstop=2 shiftwidth=2
  autocmd FileType sh   setlocal shiftwidth=4
  autocmd FileType c    setlocal cindent
  autocmd FileType html setlocal expandtab tabstop=2 shiftwidth=2
  autocmd FileType help wincmd L
  autocmd FileType asciidoc setlocal wrap
  autocmd Filetype crontab setlocal nobackup nowritebackup
  autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2
  autocmd Filetype diff setlocal foldmethod=syntax
  autocmd Filetype git setlocal foldmethod=syntax
  autocmd Filetype graphql setlocal shiftwidth=2
  autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
augroup end

augroup filetypedetect
  autocmd BufNewFile,BufRead .nginx.conf*,nginx.conf* setf nginx
  " Admittedly Pipfile.lock looks to be a subset of JSON but this is a start
  autocmd BufNewFile,BufRead Pipfile.lock setf json
augroup END

augroup python
  autocmd Filetype python nmap <leader>ptc :Pytest class<cr>
  autocmd Filetype python nmap <leader>ptfi :Pytest file<cr>
  autocmd Filetype python nmap <leader>ptfn :Pytest function<cr>
  autocmd Filetype python nmap <leader>ptm :Pytest method<cr>
  autocmd Filetype python nmap <leader>ptp :Pytest project<cr>
  autocmd Filetype python nmap <leader>pts :Pytest session<cr>
  autocmd Filetype python setlocal tw=88
augroup END

" Resize splits when window is resized
augroup window
  autocmd VimResized * :wincmd =
augroup END

" Go related mappings
" All are prefixed with 'o', because 'g' is for git
augroup go
  " FIXME - these don't seem to work
  autocmd Filetype go command! -bang Alternate call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd FileType go nmap <leader>oa :AV<cr>
  autocmd FileType go nmap <leader>ob <plug>(go-build)
  autocmd FileType go nmap <leader>oc <plug>(go-coverage-toggle)
  autocmd FileType go nmap <leader>od <plug>(go-doc-vertical)
  autocmd FileType go nmap <leader>oe <plug>(go-rename)
  autocmd FileType go nmap <leader>of <plug>(go-imports)
  autocmd FileType go nmap <leader>og <plug>(go-def-vertical)
  autocmd FileType go nmap <leader>oi <plug>(go-info)
  autocmd FileType go nmap <leader>or <plug>(go-run)
  autocmd FileType go nmap <leader>os <plug>(go-implements)
  autocmd FileType go nmap <leader>ot :GoTestFunc<cr>
  autocmd FileType go nmap <leader>ov <plug>(go-vet)
augroup END

augroup javascript
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
augroup end

" }}}

" {{{ Local Overrides

let $LOCALFILE=expand("~/.vimrc.local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif

" }}}

" vim: foldlevel=99:foldmethod=marker:expandtab:sw=2
