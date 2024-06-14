set nocompatible
set relativenumber number
set wildmenu
set laststatus=2

"call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif

"Search down into subfolders
"Provides tab-completion for all file-related tasks
set path+=**

"TAG JUMPING
"make tags file
"command! MakeTags !ctags -R .

"Autocomplete
"check |ins-completion|
"^x^n for just this file
"^x^f for filenames
"^n for general autotcomplete

"File Browsing
let g:netrw_banner=0 "disable banner
let g:netrw_browse_split=4 "open in prior window
let g:netrw_altv=1	"open splits to the right
let g:netrw_liststyle=3 "tree style
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


"set nu
filetype on
filetype indent plugin on

"plug 'vhda/verilog/verilog_systemverilog.vim'

"if has("syntax")
	"syntax on
"endif

"filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Always show current position
set ruler

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch


" Enable syntax highlighting
syntax enable

set background=dark

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

vnoremap <c-c> "+y

nnoremap \\ :noh<CR>

"function! Functionc()
	""let rettype = input('Return type? ')
	"let funcname = input('Give a proper name please ')
	"return rettype." ".funcname."(){\r\n}"
"endfunction
"inoremap <expr> ,,f Functionc()

function! ForLoopc()
  let var = input('Variable name? ')
  let bound = input('Bound? ')
  return "for (int ".var." = 0; ".
      \ var." < ".bound."; ".
      \ var."++) {\n}\eO"
endfunction
inoremap <expr> ;;f ForLoopc()

set clipboard+=unnamedplus
