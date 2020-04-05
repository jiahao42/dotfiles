set tabstop=2
set softtabstop=2
set shiftwidth=0
"set expandtab "turn tab into spaces
set autoindent
set smartindent
set smarttab
set number
"  -ic makes vim read alias in zshrc
"  but it hangs after executing external commands 
"set shellcmdflag=-ic
syntax on
colorscheme desert

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Bundle 'ervandew/supertab'
Plugin 'ycm-core/YouCompleteMe'
let g:ycm_key_list_stop_completion = ['<Enter>']
let g:ycm_autoclose_preview_window_after_completion = 1

Plugin 'SirVer/ultisnips'
Plugin 'christoomey/vim-sort-motion'
Plugin 'christoomey/vim-system-copy'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-line'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on
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

if has('eval')
  function! Compile()
    execute ':w'
    let l:ext = expand('%:e')
    let l:path = expand('%:h')
    if l:ext == "tex"
      let l:pdf = expand('%:r') . ".pdf"
      echo l:pdf
      echo l:path
      execute '!pdflatex %' 
      ". '&& xdg-open ' . l:pdf 
    elseif l:ext == "md"
      let l:pdf = expand('%:r') . ".pdf"
      echo l:pdf
      execute '!pandoc % --pdf-engine=xelatex -o ' . l:pdf . ' && xdg-open ' . l:pdf
    elseif l:ext == "py"
      execute '! clear && python3 %'
    elseif l:ext == "go"
      execute '! clear && go run %'
    endif
  endfunction

  function! Format()
    let l:ext = expand('%:e')
    if l:ext == "json"
      execute '%!jq .'
    elseif l:ext == "c" || l:ext == "cpp"
      execute '%!clang-format'
    endif
  endfunction
endif

map <F5> : call Compile() 
map <F4> : call Format()


