set hidden

" disable vi compatibility (emulation of old bugs)
set nocompatible

" line numbers
set number
set number relativenumber
set nu rnu

" wrapping
set nowrap
set formatoptions-=t

" set utf-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" disable bugs from vi
set nocompatible

" tabs
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set autoindent

" display options
set title
set ruler
set guioptions-=T

" hide instead of abandon when switching files
set hidden

" show matching braces
set showmatch

" get rid of extra file clutter
set nobackup
set nowritebackup
set noswapfile
set noundofile

" enable file-specific behavior
filetype on
filetype plugin on
filetype indent on

" disable continue comments after completing a line
au BufEnter * set fo-=c fo-=r fo-=o

" in insert mode pressing enter will create match brace
inoremap {<CR> {<CR>}<ESC>ko

" honestly i forgot what this does
let g:pyindent_open_paren = "&sw"

" multiline comments cpp
autocmd filetype cpp imap /*<CR> /**/<left><left><CR><ESC>O<tab>


" bind f5 to execute current python file
autocmd FileType python map <buffer> <F5> :w<CR>:!clear;python %<CR>
autocmd FileType python imap <buffer> <F5> :w<CR>:!clear;python %<CR>

" bind f12 will open vimrc
nnoremap <F12> :w<CR><bar>:e $MYVIMRC<CR>
nnoremap <F12> <ESC>:w<CR><bar>:e $MYVIMRC<CR>

" bind f4 to save and quit
nnoremap <F4> :wq<CR>
inoremap <F4> <ESC>:wq<CR>

" bind f2 to save
nnoremap <F2> :w<CR>
inoremap <F2> <ESC>:w<CR>

" let ctrl-c copy to clipboard
nnoremap <C-c> "+y
vnoremap <C-c> "+y

" let H and L be used to navigate tabs
nnoremap H gT
nnoremap L gt



" add tab indices
set tabline=%!MyTabLine()  " custom tab pages line
function MyTabLine()
        let s = '' " complete tabline goes here
        " loop through each tab page
        for t in range(tabpagenr('$'))
                " set highlight
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " set the tab page number (for mouse clicks)
                let s .= '%' . (t + 1) . 'T'
                let s .= ' '
                " set page number string
                let s .= t + 1 . ' '
                " get buffer names and statuses
                let n = ''      "temp string for buffer names while we loop and check buftype
                let m = 0       " &modified counter
                let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
                " loop through each buffer in a tab
                for b in tabpagebuflist(t + 1)
                        " buffer types: quickfix gets a [Q], help gets [H]{base fname}
                        " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
                        if getbufvar( b, "&buftype" ) == 'help'
                                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
                        elseif getbufvar( b, "&buftype" ) == 'quickfix'
                                let n .= '[Q]'
                        else
                                let n .= pathshorten(bufname(b))
                        endif
                        " check and ++ tab's &modified count
                        if getbufvar( b, "&modified" )
                                let m += 1
                        endif
                        " no final ' ' added...formatting looks better done later
                        if bc > 1
                                let n .= ' '
                        endif
                        let bc -= 1
                endfor
                " add modified label [n+] where n pages in tab are modified
                if m > 0
                        let s .= '[' . m . '+]'
                endif
                " select the highlighting for the buffer names
                " my default highlighting only underlines the active tab
                " buffer names.
                if t + 1 == tabpagenr()
                        let s .= '%#TabLineSel#'
                else
                        let s .= '%#TabLine#'
                endif
                " add buffer names
                if n == ''
                        let s.= '[New]'
                else
                        let s .= n
                endif
                " switch to no underlining and add final space to buffer list
                let s .= ' '
        endfor
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
                let s .= '%=%#TabLineFill#%999Xclose'
        endif
        return s
endfunction


" bind hotkey to open files
" autocmd filetype cpp nnoremap <F1> :%d<CR><bar>:-1read C:\\Program Files\\Vim\\cp.cpp<CR>:2<CR>a<C-R>=strftime("%b %d, %Y")<CR><ESC>:3<CR>A<C-R>=strftime("%I:%M %p CST")<CR><ESC>:10<CR>i<end>
" autocmd filetype cpp inoremap <F1> <ESC>:%d<CR><bar>:-1read C:\\Program Files\\Vim\\cp.cpp<CR>:2<CR>a<C-R>=strftime("%b %d, %Y")<CR><ESC>:3<CR>A<C-R>=strftime("%I:%M %p CST")<CR><ESC>:10<CR>i<end>

" autocmd filetype python nnoremap <F1> :%d<CR><bar>:-1read C:\\Program Files\\Vim\\python.py<CR>:3<CR>a<C-R>=strftime("%b %d, %Y")<CR><ESC>:4<CR>A<C-R>=strftime("%I:%M %p CST")<CR><ESC>:18<CR>i<end>
" autocmd filetype python inoremap <F1> <ESC>:%d<CR><bar>:-1read C:\\Program Files\\Vim\\python.py<CR>:3<CR>a<C-R>=strftime("%b %d, %Y")<CR><ESC>:4<CR>A<C-R>=strftime("%I:%M %p CST")<CR><ESC>:18<CR>i<end>



" in normal mode F5 will save, clear terminal, compile, and run current C++ program (C++ 17)
autocmd filetype cpp nnoremap <F5> :w <bar> !clear && g++ -std=c++17 -O2 -Wall % -o %:r && %:r.exe <CR>
" autocmd filetype cpp nnoremap <F5> :w <bar> !clear && g++ -std=c++17 -O2 -Wall % -o %:r && %:r.exe <CR>
" in insert mode (same thing as above)
autocmd filetype cpp inoremap <F5> <ESC>:w <bar> !clear && g++ -std=c++17 -O2 -Wall % -o %:r && %:r.exe <CR>


" in normal mode F5 will save, clear terminal, compile, and run current C++ program (C++ 11)
autocmd filetype c nnoremap <F5> :w <bar> !cls && g++ -std=c++11 -O2 -Wall % -o %:r && %:r.exe <CR>
" in insert mode (same thing as above)
autocmd filetype c inoremap <F5> <ESC>:w <bar> !cls && g++ -std=c++11 -O2 -Wall % -o %:r && %:r.exe <CR>


" in normal mode F5 will save, clear terminal, and run current python program
autocmd filetype python nnoremap <F5> :w <bar> !clear && py %<CR>
" in insert mode (same thing as above)
autocmd filetype python inoremap <F5> <ESC>:w <bar> !clear && py %<CR>

