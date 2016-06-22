let s:thisf = expand('<sfile>')
let s:did_activate = 0

fun! vim_addon_WaldonChen#Activate()
	if s:did_activate | return | endif
	let s:did_activate = 1

	call vim_addon_WaldonChen#BasicSettings()
endf

function! vim_addon_WaldonChen#BasicSettings()
    set nu
	set so=7
	set wildmenu
    set wildignore=*.o,*~,*.pyc
	set backspace=eol,start,indent
	set whichwrap+=b,s,<,>,[,]
    set lazyredraw

    "------------------------
    " Find and replace
    "------------------------
    set mat=2
    set magic
    set showmatch
	set ignorecase
	set smartcase
	set hlsearch
	set incsearch

    " Replace the selected text in visual mode
    vmap <leader>s y:%s/<C-R>=escape(@", '\\/.*$^~[]')<CR>/

    "------------------------
    " Color scheme
    "------------------------
	colo desert
	set colorcolumn=81
	set t_Co=256
	set cursorline
    highlight ColorColumn ctermbg=235 guibg=lightgrey

    if has("gui_gtk2")
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 11,Fixed\ 11
        set guifontwide=Microsoft\ Yahei\ 11,WenQuanYi\ Zen\ Hei\ 11
    endif

    "------------------------
    " Indent
    "------------------------
	set autoindent
	set smartindent
	set cindent

    "------------------------
    " Tab
    "------------------------
	set smarttab
	set tabstop=4
	set shiftwidth=4
	set softtabstop=4
	set expandtab
	autocmd FileType makefile,html,xml,php set noexpandtab
	autocmd FileType ruby,html,xml,xhtml,php set ts=2 | set sw=2 | set sts=2

    "------------------------
    " Files
    "------------------------
    set fileencodings=utf-8,gb18030,gbk,big5,latin1
    set termencoding=utf-8,gbk

    nmap <silent> <leader>fs :w<CR>
    nmap <Leader>W :w !sudo tee % > /dev/null

    " Return to last edit position when opening files
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \	exe "normal! g`\"" |
                \ endif

    " create directory for files before Vim tries writing them:
    augroup CREATE_MISSING_DIR_ON_BUF_WRITE
        au!
        autocmd BufWritePre * if !isdirectory(expand('%:h', 1)) | call mkdir(expand('%:h', 1),'p') | endif
    augroup end

    " Delete trailing white space on save
    func! DeleteTrailingWS()
        " Save the current search and cursor position
        let _s = @/
        let l = line('.')
        let c = col('.')

        " Strip the whitespace
        silent! %s/\s\+$//ge

        " Restore the saved search and cursor position
        let @/ = _s
        call cursor(l, c)
    endfunc
    nmap <silent> ;m :call DeleteTrailingWS()<CR>
    " autocmd BufWrite *.py :call DeleteTrailingWS()

    "------------------------
    " Buffers
    "------------------------
    set pastetoggle=<F3>

    nmap <leader>bb :ls<CR>
    nmap <Leader>bd :bd<CR>
    nmap <Leader>bn :bn<CR>
    nmap <Leader>bp :bp<CR>
    nmap <Leader><Tab> :b#<CR>

    " Switch CWD to the directory of the open buffer
    nmap <leader>cd :cd %:p:h<CR>:pwd<CR>

    " Remember info about open buffers on close
    set viminfo^=%

    " Specify the behavior when switching between buffers
    try
        set switchbuf=useopen,usetab,newtab
        set stal=2
    catch
    endtry

    "------------------------
    " Windows
    "------------------------
    map j gj
    map k gk
    map <C-h> <C-W>h
    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-l> <C-W>l
    map <leader>w <C-W>
    map <leader>w/ <C-w>v

endfunction
