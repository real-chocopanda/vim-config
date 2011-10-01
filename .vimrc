" VIM Configuration
" Original comes from Vincent Jousse
" Modified by William Durand <william.durand1@gmail.com>

filetype off
" Use pathogen so that we choose to load one of two versions of the same command-t plugin depending of the host arch (i386, x86_64)
let host_arch=substitute(system('uname -i'), "\n", "", "")
call pathogen#infect('bundle-'.host_arch)
call pathogen#helptags()
filetype on

" Set title on X window
set title

" Global
set hidden ruler wmnu               " Hide buffer instead of abandoning when unloading

set wildmenu                        " Enhanced command line completion.
set wildmode=list:longest           " Complete files like a shell.
set wildignore=.svn,CVS,.git,.hg,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*.pyc,*.pyo " Ignore certain files

set showcmd                         " Display incomplete commands.
set showmode                        " Display the mode you're in.

syntax on

" Color scheme
let &t_Co=256         " force the 256-color mode
colorscheme mustang

set number                          " Show line numbers.
set cursorline
hi cursorline cterm=none term=none  " Highlight current line, disable underlining

set incsearch                       " Highlight matches as you type.
set hlsearch                        " Highlight matches.
set ignorecase                      " Search in insensitive case
set smartcase                       " Search like ack with maj on ly if a maj

set wrap                            " Turn on line wrapping.
set scrolloff=3                     " Show 3 lines of context around the cursor.

" set visualbell                      " No beeping.
set shortmess+=filmnrxoOtT          " abbrev. of messages (avoids 'hit enter')

set nobackup                        " Don't make a backup before overwriting a file.
set nowritebackup                   " And again.
set noswapfile                      " Use an SCM instead of swap files

set laststatus=2                    " Show the status line all the time

set backspace=indent,eol,start      " http://vim.wikia.com/wiki/Backspace_and_delete_problems

set expandtab
set copyindent                      " copy the previous indentation on autoindenting
set shiftround                      " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch                       " set show matching parenthesis
set autoindent

set undolevels=1000                 " use many levels of undo



if version >= 730
    set noundofile                  " Don't keep a persistent undofile
endif

" http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
" F2 = toggle paste mode
nnoremap <F2> :set invpaste paste?<Enter>
imap <F2> <C-O><F2>
set pastetoggle=<F2>

" Make the view port scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Resize splitted views faster
nnoremap <C-w>< 5<C-w><
nnoremap <C-w>> 5<C-w>>

" Remap the marker char
nnoremap ' `
nnoremap ` '

" Line number toggle with F12
noremap <silent> <F12> :set number!<CR>

" Command and search pattern history
set history=1000

" Redifinition of map leader
let mapleader = ","

" make plugins smoother
set lazyredraw

" Always replace all occurences of a line
set gdefault

" Tabs and indentation. Yes, I like 4-space tabs (Symfony2 here we go !)
set tabstop=4
set shiftwidth=4
set softtabstop=4

nmap <leader>2 :set tabstop=2<cr>:set shiftwidth=2<cr>:set softtabstop=2<cr>
nmap <leader>4 :set tabstop=4<cr>:set shiftwidth=4<cr>:set softtabstop=4<cr>

" Sudo to write
command W w !sudo tee % > /dev/null

" Pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>zs :%s/<C-r>=expand("<cword>")<CR>/

" Pull word under cursor into Ack for a global search
map <leader>za :Ack "<C-r>=expand("<cword>")<CR>"

" Start a substitute
map <leader>s :%s/

" Ack
nmap <leader>a :Ack<space>

" Clear search highlight
map <silent> <leader>/ :let @/=""<CR>:echo "Cleared search register."<cr>


filetype on
filetype plugin on
filetype indent on


" Ctags
" set nocp
" set tags=tags
" map <silent><leader><Left> <C-T>
" map <silent><leader><Right> <C-]>
" map <silent><leader><Up> <C-W>]

"OmniCppComplete
" let OmniCpp_NamespaceSearch     = 1
" let OmniCpp_GlobalScopeSearch   = 1
" let OmniCpp_ShowAccess          = 1
" let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
" let OmniCpp_MayCompleteDot      = 1 " autocomplete after .
" let OmniCpp_MayCompleteArrow    = 1 " autocomplete after ->
" let OmniCpp_MayCompleteScope    = 1 " autocomplete after ::
" let OmniCpp_DefaultNamespaces   = ["std", _GLIBCXX_STD"]

" Completion
set complete=.,w,b,u,t,i,k~/.vim/syntax/php.api
au FileType php set omnifunc=phpcomplete#CompletePHP

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Allow extended digraphs
set encoding=utf-8

" Disable folding
set nofoldenable

" My information
iab xdate <C-R>=strftime("%d/%m/%Y %H:%M:%S")

" Markdown
au! BufRead,BufNewFile *.markdown,*.md set filetype=mkd
au! BufRead,BufNewFile *.md set filetype=mkd

" reStructuredText
au! BufRead,BufNewFile *.rst set filetype=rst

" Twig
au BufNewFile,BufRead *.twig set filetype=twig
" Twig surrounding
let g:surround_{char2nr('-')} = "{% \r %}"

" PHP/HTML
let php_htmlInStrings = 1
let php_sql_query = 1
" run file with PHP CLI (CTRL-M)
autocmd FileType php noremap <C-M> :w!<CR>:!/usr/bin/php %<CR>
" PHP parser check (CTRL-L)
autocmd FileType php noremap <C-L> :!/usr/bin/php -l %<CR>

"Invisible character
nmap <leader>l :set list!<CR>
set listchars=nbsp:¤,tab:>-,trail:¤,extends:>,precedes:<,eol:¬,trail:·

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Does not work under version 7.1.6
if version >= 716
    autocmd BufWinLeave * call clearmatches()
endif

" automatically remove trailing whitespace before write
function! StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    if line("'Z") != line(".")
        echo "Stripped whitespace\n"
    endif
    normal `Z
endfunction
autocmd BufWritePre *.php,*.yml,*.xml,*.js,*.html,*.css,*.java,*.c,*.cpp,*.vim :call StripTrailingWhitespace()

set statusline+=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P

" Syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_quiet_warnings=0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" Tab mappings.
map <leader>te :tabedit<space>
map <leader>tc :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove<cr>
map <leader>tr :tabrewind<cr>

let g:CommandTMaxHeight=15

fun SetupVAM()
  " YES, you can customize this vam_install_path path and everything still works!
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " * unix based os users may want to use this code checking out VAM
  " * windows users want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, unzip, git tool chain first
  if !isdirectory(vam_install_path.'/vim-addon-manager') && 1 == confirm("git clone VAM into ".vam_install_path."?","&Y\n&N")
    " I'm sorry having to add this reminder. Eventually it'll pay off.
    call confirm("Remind yourself that most plugins ship with documentation (README*, doc/*.txt). Its your first source of knowledge. If you can't find the info you're looking for in reasonable time ask maintainers to improve documentation")
    exec '!p='.shellescape(vam_install_path).'; mkdir -p "$p" && cd "$p" && git clone --depth 1 git://github.com/MarcWeber/vim-addon-manager.git'
  endif

  call vam#ActivateAddons(['ack', 'snipmate-snippets', 'Syntastic', 'The_NERD_tree'], {'auto_install' : 0})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})
  " where pluginA could be github:YourName or snipmate-snippets see vam#install#RewriteName()
  " also see section "5. Installing plugins" in VAM's documentation
  " which will tell you how to find the plugin names of a plugin
endf
call SetupVAM()
" experimental: run after gui has been started (gvim) [3]
" option1: au VimEnter * call SetupVAM()
" option2: au GUIEnter * call SetupVAM()
" See BUGS sections below [*]

