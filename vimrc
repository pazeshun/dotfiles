set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smarttab
filetype plugin indent on
set number
"set clipboard=unnamed
set incsearch
set whichwrap=<,>,[,]
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

"visualize tab and white space of EOL
set list
set listchars=tab:>-,trail:-

"vim-plug
call plug#begin('~/.vim/plugged')
"vim-ros
Plug 'https://github.com/taketwo/vim-ros.git'
"vim-operator-user
Plug 'https://github.com/kana/vim-operator-user.git'
"vim-clang-format
Plug 'https://github.com/rhysd/vim-clang-format.git'
"previm
Plug 'https://github.com/kannokanno/previm.git'
"open-browser.vim
Plug 'https://github.com/tyru/open-browser.vim.git'
"conque.vim
Plug 'https://github.com/pazeshun/conque.vim.git'
call plug#end()

"vim-clang-format
let g:clang_format#command = "clang-format-3.6"
let g:clang_format#detect_style_file = 1
autocmd FileType c,cpp map <buffer> = <Plug>(operator-clang-format)

"Completion in conque for lisp
autocmd FileType conque_term setl iskeyword=38,42,43,45,47-58,60-62,64-90,97-122,_,+,-,*,/,%,<,=,>,:,$,?,!,@-@,94
autocmd FileType conque_term inoremap <buffer> <S-tab> <C-p>
autocmd FileType conque_term imap <buffer> <F8> <Esc>lve<F9>

autocmd FileType c,cpp setl cindent
autocmd FileType cpp setl cinoptions=i-s,N-s,g0

autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
"autocmd FileType python setl nocindent

let g:lisp_rainbow = 1
autocmd FileType lisp setl nocindent
autocmd FileType lisp setl lisp
autocmd FileType lisp setl showmatch
autocmd FileType lisp setl tabstop=8 expandtab shiftwidth=2 softtabstop=2

autocmd FileType make setl noexpandtab
