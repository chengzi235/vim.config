set t_Co=256
set term=xterm-256color
set autoread						" 设置当文件被改动时自动载入
syntax on
syntax enable						" 语法高亮

" colorscheme space-vim-dark 
" colorscheme railscasts
" colorscheme molokai
set clipboard=unnamed				" 共享剪贴板  
set nobackup						" 从不备份  
set autowrite						" 自动保存
set cursorline						" or set cul 设置光标所在的行
set magic							" 设置魔术
set guioptions-=T					" 隐藏工具栏
set guioptions-=m					" 隐藏菜单栏
set foldcolumn=0
set foldmethod=indent 
set foldlevel=3 
set foldlevelstart=99 
set nocompatible					" 不要使用vi的键盘模式，而是vim自己的
set noeb							" 去掉输入错误的提示声音
set confirm							" 在处理未保存或只读文件的时候，弹出确认
set autoindent						" 自动缩进
set cindent
set tabstop=4						" Tab键的宽度
set softtabstop=4					" 统一缩进为4
set shiftwidth=4
set smarttab						" 在行和段开始处使用制表符
set number							" 显示行号
set history=1000					" 历史记录数
set nobackup						" 禁止生成临时文件
set noswapfile
set ignorecase						" 搜索忽略大小写
set hlsearch						" 搜索逐字符高亮
set incsearch
set gdefault						" 行内替换
set enc=utf-8						" 编码设置
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8			" 语言设置
set helplang=cn
set laststatus=2					" 总是显示状态行
set cmdheight=1						" 命令行（在状态行下）的高度，默认为1，这里是2
filetype on							" 侦测文件类型
filetype plugin on					" 载入文件类型插件
filetype indent on					" 为特定文件类型载入相关缩进文件
set viminfo+=!						" 保存全局变量
set iskeyword+=_,$,@,%,#,-			" 带有如下符号的单词不要被换行分割
set linespace=0						" 字符间插入的像素行数目
set wildmenu						" 增强模式中的命令行自动完成操作
set backspace=2						" 使回格键（backspace）正常处理indent, eol, start等
set whichwrap+=<,>,h,l				" 允许backspace和光标键跨越行边界
set report=0						" 通过使用: commands命令，告诉我们文件的哪一行被改变过
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
set showmatch						" 高亮显示匹配的括号
set matchtime=1						" 匹配括号高亮的时间（单位是十分之一秒）
set scrolloff=3						" 光标移动到buffer的顶部和底部时保持3行距离
set smartindent						" 为C程序提供自动缩进
" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt
" 自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {<CR>}<ESC>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction
filetype plugin indent on 
" 打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu

"			plugin
" 启用vundle来管理vim插件
" 常用命令
" :PluginList       - 查看已经安装的插件
" :PluginInstall    - 安装插件
" :PluginUpdate     - 更新插件
" :PluginSearch     - 搜索插件
" :PluginClean      - 删除插件，把安装插件对应行删除，然后执行这个命令即可
" h: vundle         - 获取帮助
set rtp+=~/.vim/plugins/Vundle.vim
call vundle#begin()
" 安装插件写在这之后
Plugin 'vim-utils/vim-man'
Plugin 'bling/vim-airline'
Plugin 'junegunn/fzf.vim'
Plugin 'Yggdroot/LeaderF'
Plugin 'voldikss/vim-floaterm'
" 安装插件写在这之前
call vundle#end() " required
filetype plugin on " required

"---------------------------vim-man配置--------------------------------------
source $VIMRUNTIME/ftplugin/man.vim
" 按m横屏显示manpage
nmap m :Man <C-R>=expand("<cword>")<CR><CR>
" 按vm竖屏显示manpage
nmap vm :Vman <C-R>=expand("<cword>")<CR><CR>

"---------------------------airline配置--------------------------------------
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'

" 是否打开tabline
let g:airline#extensions#tabline#enabled = 1 

let mapleader=" "

" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }
let g:Lf_PopupHeight = 0.7
let g:Lf_PopupWidth = 0.999

" leaderf keymap
noremap <leader>fg :<C-U><C-R>=printf("Leaderf rg -g '*.c' -g '*.h' -g '*.S' -s -e %s ", expand("<cword>"))<CR>
noremap <leader>ff :LeaderfFile<CR>
noremap <leader>ft :LeaderfBufTagAll<CR>
noremap <leader>fb :LeaderfBuffer<CR>

" floaterm
noremap <leader>t :FloatermNew --height=0.8 --width=0.9 --wintype=float --name=floaterm --autoclose=2<CR>
