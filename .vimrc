set shell=/bin/bash         " 设置使用的shell路径
set undodir=$HOME/.undodir  " 设置撤销临时文件存放目录，默认与当前文件同级

lang messages zh_CN.UTF-8   " 设置中文界面
set ai!                     " 设置自动缩进
set nu!                     " 显示行号
set ruler                   " 在右下角显示光标的坐标
set cindent                 " 使用C语言的规则自动缩进
set showcmd                 " 在ruler左边显示当前正在输入的命令
set hlsearch                " 开启高亮显示结果
set expandtab               " 将tab键改为空格，默认是8个
set tabstop=4               " 设置tab键的宽度
set showmatch               " 显示括号配对情况
set incsearch               " 开启实时搜索功能
" set nowrapscan              " 搜索到文件两端时不重新搜索
" set cursorline              " 突出显示当前行
set autoindent              " 自动对齐
set smartindent             " 智能自动缩进
set backspace=2             " 设置退格键可用
set shiftwidth=4            " 自动缩进时，使用4个空格，默认是8个
"set hidden                 " 允许在有未保存的修改时切换缓冲区
""set list                   " 显示Tab符，使用一高亮竖线代替
syntax enable               " 打开语法高亮
"set background=dark
"colorscheme solarized
syntax on                   " 开启文件类型侦测
filetype on                 " 
filetype indent on          " 针对不同的文件类型采用不同的缩进格式
filetype plugin on          " 针对不同的文件类型加载对应的插件
set nobackup                " 设置无备份文件
set nocompatible            " 不使用vi兼容的模式
"set cc=120                   " 80字符界限
"
"设置编码格式
set enc=utf-8               " 设置编码
set fenc=utf-8             " 设置文件编码
set encoding=utf-8
set fileencodings=ucs-born,utf-8,cp936
"" 设置文件编码检测类型及支持格式

"使用Vundle来管理Vundle
set nocompatible
filetype off
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()

"Bundle 'gmarik/vundle'
"
""PowerLine插件 状态栏增强展示
Bundle 'Lokaltog/vim-powerline'
Bundle 'The-NERD-tree' " NERD-TREE文件树 
Bundle 'The-NERD-Commenter'
Bundle 'neocomplcache'
"vim有一个状态栏 加上powline则有两个状态栏
"set laststatus=2
"set t_Co=256
"let g:Powline_symbols='fancy'
"
"Vundle配置必须 开启插件
filetype plugin indent on

" NERDTree配置
let NERDTreeWinSize=24
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
nmap <F2> <ESC>:NERDTreeToggle<RETURN>

" 设置PHP自动补全
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

" PHP注释添加
source $HOME/.vim/autoload/php-doc.vim
inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-D> :call PhpDocSingle()<CR>
vnoremap <C-D> :call PhpDocRange()<CR> 

" PHP 自动完成
" " 设置自动完成的监听方式：尾部添加一个字母和清除一个字母
set complete-=k complete+=k
" 设置字典补全文件
set dictionary=$HOME/.vim/bundle/vim-php-dict/php.dict
" 使用 tab 键自动完成或尝试自动完成
function! InsertTabWrapper()
    let col=col('.')-1
    if !col || getline('.')[col-1] !~ '\k'
        return "\<TAB>"
    else
        return "\<C-p>"
    endif
endfunction
" 重新映射 tab 键到 InsertTabWrapper 函数
inoremap <TAB> <C-R>=InsertTabWrapper()<CR>

" Ctags 自动跳转
map <F12> :!/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"   let g:neocomplcache_enable_at_startup = 1  " 作用：在系统启动的时候启动neo  
let g:NeoComplCache_DisableAutoComplete = 1
let g:neocomplcache_enable_auto_select = 1

"" inoremap ( () <ESC>hi
"" inoremap [ [] <ESC>hi
"" inoremap { {} <ESC>hi
"" inoremap < <> <ESC>hi
"" inoremap ' '' <ESC>hi
"" inoremap " "" <ESC>hi
"" inoremap <f3> <ESC>lli

" tagsList 函数树
"
let Tlist_Inc_Winwidth=0 
let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1

" cscope 
map <F11> :!find $PWD -name "*.php"  -o -name '*.inc' -o -name '*.module' > cscope.files && cscope -bq<CR>
"让跳转到定义的命令:ta 和 Ctrl-]调用ctags的tag，帮助:help nocst。
set nocst
"优先使用ctags的tag  
set csto=1
"set cscopequickfix=s-,c-,d-,i-,t-,e-    "使:cs find c 时直接跳转而不是列表，看个人喜好要不要设这个。
"光标放在函数上，快捷键Ctrl-跳转到调用这个函数的地方
"nnoremap <C-s> :cs find c <C-R>=expand("<cword>")<CR><CR>
""光标放在函数上，快捷键Ctrl-_跳转到函数定义处或列出多个定义
"nnoremap <C-g> :cs find g <C-R>=expand("<cword>")<CR><CR>
""搜索函数定义的位置
"map <C-g> :cs find g <C-R>=expand("<cword>")<CR>

if filereadable("cscope.out")
    cs add $PWD/cscope.out
endif

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cword>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>
