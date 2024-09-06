"
" Title:  My .virc file
" Author: Nelson Lima
" Date:   05-11-2020
"

set autochdir

" Signcolumn

set number
set relativenumber
set signcolumn=yes
set updatetime=100
set clipboard=unnamed
set mouse:a

" Indentation

set autoindent
set smartindent
set shiftround
set expandtab
set backspace=indent,eol,start
set list lcs=tab:\ \ ,trail:~

" Colorshceme

colorscheme slate
autocmd vimenter * hi Normal ctermbg=NONE
autocmd vimenter * hi SignColumn ctermbg=NONE
autocmd ColorScheme * hi SignColumn ctermbg=NONE
autocmd vimenter * hi VertSplit ctermbg=DarkGrey
autocmd vimenter * hi VertSplit ctermfg=DarkGrey
syntax on

" Custom shortcuts

" Functions

function! CompileAndRunCode()
        if &filetype == "python"
                exec "!clear &&printf '\e[3J' ; python3 %"
        elseif &filetype == "javascript"
                exec "!clear &&printf '\e[3J' ; node %"
        elseif &filetype == "rust"
                exec "!clear &&printf '\e[3J' ; cargo run"
        elseif &filetype == "sh"
                exec "!clear &&printf '\e[3J'; chmod +x % ; ./%"
        elseif &filetype == "c"
                exec "!clear &&printf '\e[3J' ; gcc -o %:r %;./%:r"
        elseif &filetype == "cpp"
                exec "!clear &&printf '\e[3J' ; g++ --std=c++17 % -Wall -fsanitize=address,undefined;./a.out"
        elseif &filetype == "php"
                exec "!clear &&printf '\e[3J' ; php %"
        elseif &filetype == "arduino"
                "exec \"!clear &&printf '\e[3J' ; arduino-cli compile -b arduino:avr:uno %"
                CompileArduino
        elseif &filetype == "java"
                exec "!clear &&printf '\e[3J' ; javac % -d ../bin -cp ../bin; java -cp ../bin/ %:r"
        else
                echo "Filetype not Supported"
        endif
endfunction

function! TestCode()
        if &filetype == "python"
                exec "!clear && printf '\e[3J' ; pytest -v test.py"
        else
                echo "Filetype not Supported"
        endif
endfunction

" Actual shortcuts

map <F2> <esc><C-w>w
imap <F2> <esc><C-w>w

map <F3> <esc>:below term<CR>
imap <F3> <esc>:below term<CR>

if &filetype == "html"
        map <F4> :w<CR>:below term<CR>live-server<CR>
        imap <F4> <esc>:w<CR>:below term<CR>live-server<CR>
elseif &filetype == or("typescriptreact","javascriptreact")
        map <F4> :w<CR>:below term<CR>npm run dev<CR>
        imap <F4> <esc>:w<CR>:below term<CR>npm run dev<CR>
endif

map <F5> <esc>:call CompileAndRunCode()<CR>
imap <F5> <esc>:call CompileAndRunCode()<CR>

map <F6> <esc>:call TestCode()<CR>
imap <F6> <esc>:call TestCode()<CR>

map <F10> <esc>:NERDTree<CR>
imap <F10> <esc>:NERDTree<CR>
