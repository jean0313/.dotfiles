

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'file://~/.vim/bundle/nerdtree'
"Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'https://github.com/kien/ctrlp.vim'
Plugin 'https://github.com/majutsushi/tagbar'


Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'fatih/molokai'
Plugin 'AndrewRadev/splitjoin.vim'
"Plugin 'https://github.com/Valloric/YouCompleteMe'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


syntax on

set termencoding=utf-8
set encoding=utf-8

set shortmess+=I					" Don't show the Vim welcome screen.

set autoindent						" copy indent from current line for new line
set nosmartindent					" 'smartindent' breaks right-shifting of # lines
set backspace=indent,eol,start		" set backspace config, backspace as normal

set hidden							" hide buffers instead of closing them

set history=1000					" sets how many lines of history VIM has to remember
set ruler							" always show current position
set showcmd							" show typed commands
set showmode						" display the mode you're in
set incsearch						" go to search results as typing
set hlsearch						" highlight search things
set number							" display line numbers
set numberwidth=4					" minimum of 4 columns for line numbers
set laststatus=2					" always show the statusline
set visualbell t_vb=				" no beeps or flashes

set scrolloff=3						" show 3 lines of context around the cursor (top and bottom)
set sidescrolloff=5					" show 5 lines of context around the cursor (left and right)
set sidescroll=1					" number of chars to scroll when scrolling sideways

set expandtab					" insert tabs rather than spaces for <Tab>
set smarttab						" tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4						" the visible width of tabs
set softtabstop=4					" edit as if tabs are 4 characters wide
set shiftwidth=4					" number of spaces to use for indent and unindent
set shiftround						" round indent to a multiple of 'shiftwidth'

set ignorecase						" ignore case for pattern matches
set smartcase						" override 'ignorecase' if pattern contains uppercase

set cursorline						" highlight current line, for quick orientation

set confirm							" raise a dialog asking if changes should be saved

set nomodeline						" Ignore modelines
set nojoinspaces					" Don't get fancy with the spaces when joining lines
set textwidth=0						" don't auto-wrap lines except for specific filetypes

set fileformats=unix,mac,dos		" support all three filetypes in this order
set spelllang=en
set wildignorecase
set lazyredraw						" redraw less frequently
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
			\,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
			\,sm:block-blinkwait175-blinkoff150-blinkon175
set updatetime=100					" More responsive UI updates

let mapleader = "\ "

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ctrip
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" 设置过滤不进行查找的后缀名
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

" uoucompleteme
" 设置跳转到方法/函数定义的快捷键
nnoremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 触发补全快捷键
let g:ycm_key_list_select_completion = ['<TAB>', '<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<c-p>', '<Up>']
let g:ycm_auto_trigger = 1
" 最小自动触发补全的字符大小设置为 3
let g:ycm_min_num_of_chars_for_completion = 3
" YCM的previw窗口比较恼人，还是关闭比较好
set completeopt-=preview 

" tagbar
nmap <F8> :TagbarToggle<CR>

" airline
let g:airline#extensions#tabline#enabled = 1

" vim-go
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

let g:go_list_type = "quickfix"
autocmd FileType go nmap <leader>t  <Plug>(go-test)
autocmd FileType go nmap <leader>b  <Plug>(go-build)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
let g:go_fmt_command = "goimports"
let g:go_textobj_include_function_doc = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

let g:go_def_mode = 'godef'
autocmd FileType go nmap <Leader>i <Plug>(go-info)
let g:go_auto_type_info = 1
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 

" nerdtree
nmap <F7> :NERDTreeToggle<CR> 

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
