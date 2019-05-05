let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
		echo "Downloading junegunn/vim-plug to manage plugins..."
		silent !mkdir -p ~/.config/nvim/autoload/
		silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'lumiliet/vim-twig'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'LukeSmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'vifm/vifm.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'sheerun/vim-polyglot'
" Dev plugins
Plug 'editorconfig/editorconfig-vim'
Plug 'mattn/emmet-vim'
" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
" Syntax
"Plug 'StanAngeloff/php.vim'
"Plug 'stephpy/vim-php-cs-fixer'
" Tags
"Plug 'ludovicchabant/vim-gutentags'
" Completion
"Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'phpactor/ncm2-phpactor'
" Snippets
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
" PHPDoc
"Plug 'tobyS/vmustache'
"Plug 'tobyS/pdv'

" WIP
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'phpactor/phpactor', { 'do': ':call phpactor#Update()', 'for': 'php'}
Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'w0rp/ale'
Plug 'Rican7/php-doc-modded'
Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
Plug 'alvan/vim-php-manual', {'for': 'php'}
Plug 'amiorin/vim-project'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
" only show MRU files from within your cwd
let g:fzf_mru_relative = 1
call plug#end()

augroup ncm2
  au!
  autocmd BufEnter * call ncm2#enable_for_buffer()
  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupClose set completeopt=menuone
augroup END

" parameter expansion for selected entry via Enter
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

" cycle through completion entries with tab/shift+tab
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" PHP7
let g:ultisnips_php_scalar_types = 1

" update tags in background whenever you write a php file
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1

command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
map <c-s> <esc>:w<cr>:Silent php-cs-fixer fix %:p --level=symfony<cr>

let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"
let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <leader>reu :call PhpExtractUse()<CR>
vnoremap <leader>rec :call PhpExtractConst()<CR>
nnoremap <leader>rep :call PhpExtractClassProperty()<CR>
nnoremap <leader>rnp :call PhpCreateProperty()<CR>
nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>

" context-aware menu with all functions (ALT-m)
nnoremap <m-m> :call phpactor#ContextMenu()<cr>

nnoremap gd :call phpactor#GotoDefinition()<CR>
nnoremap gr :call phpactor#FindReferences()<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
" extract variable
vnoremap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
nnoremap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
" extract interface
nnoremap <silent><Leader>rei :call phpactor#ClassInflect()<CR>
let g:phpactor_executable = '~/.config/nvim/plugged/phpactor/bin/phpactor'

nnoremap <leader>h :call UpdatePhpDocIfExists()<CR>
function! UpdatePhpDocIfExists()
    normal! k
    if getline('.') =~ '/'
        normal! V%d
    else
        normal! j
    endif
    call PhpDocSingle()
    normal! k^%k$
    if getline('.') =~ ';'
        exe "normal! $svoid"
    endif
endfunction

function! PHPModify(transformer)
    :update
    let l:cmd = "silent !".g:phpactor_executable." class:transform ".expand('%').' --transform='.a:transformer
    execute l:cmd
endfunction

nnoremap <leader>rcc :call PhpConstructorArgumentMagic()<cr>
function! PhpConstructorArgumentMagic()
    " update phpdoc
    if exists("*UpdatePhpDocIfExists")
        normal! gg
        /__construct
        normal! n
        :call UpdatePhpDocIfExists()
        :w
    endif
    :call PHPModify("complete_constructor")
endfunction

nnoremap <leader>ric :call PHPModify("implement_contracts")<cr>
nnoremap <leader>raa :call PHPModify("add_missing_properties")<cr>
nnoremap <leader>rmc :call PHPMoveClass()<cr>
function! PHPMoveClass()
    :w
    let l:oldPath = expand('%')
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
    execute "bd ".l:oldPath
    execute "e ". l:newPath
endfunction
nnoremap <leader>rmd :call PHPMoveDir()<cr>
function! PHPMoveDir()
    :w
    let l:oldPath = input("old path: ", expand('%:p:h'))
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
endfunction

nnoremap <Leader>u :PHPImportClass<cr>
nnoremap <Leader>e :PHPExpandFQCNAbsolute<cr>
nnoremap <Leader>E :PHPExpandFQCN<cr>

let g:php_manual_online_search_shortcut = '<leader>k'

let g:project_use_nerdtree = 1
let g:project_enable_welcome = 1
set rtp+=~/.vim/bundle/vim-project/
"call project#rc("~/code")

" project's configuration in a separate file
so ~/.vimprojects
nmap <leader><F2> :e ~/.vimprojects<cr>

" Example
"Project 'aSymfony3Project'
"Callback 'aSymfony3Project', 'ApplySf3Settings'
"function! ApplySf3Settings(...) abort
"    map <c-s> :Silent php-cs-fixer fix %:p --level=symfony<cr>
"endfunction

nnoremap <leader><Enter> :FZFMru<cr>
" to enable found references displayed in fzf
let g:LanguageClient_selectionUI = 'fzf'

nnoremap <leader>s :Rg<space>
" word under cursor
nnoremap <leader>R :exec "Rg ".expand("<cword>")<cr>
" search for visual selection
vnoremap // "hy:exec "Rg ".escape('<C-R>h', "/\.*$^~[()")<cr>

autocmd! VimEnter * command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --smart-case --line-number --color=always --no-heading --fixed-strings --follow --glob "!.git/*" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <leader>, :Files<cr>
" vertical split
nnoremap <leader>. :call fzf#run({'sink': 'e', 'right': '40%'})<cr>
nnoremap <leader>d :BTags<cr>
" word under cursor
nnoremap <leader>D :BTags <C-R><C-W><cr>
nnoremap <leader>S :Tags<cr>
" hit enter to jump to last buffer
nnoremap <leader><tab> :Buffers<cr>

" END WIP

" Airline (powerline)
let g:airline_powerline_fonts = 1
let g:airline_theme='violet'

" disables automatic code folding
set nofoldenable

let NERDTreeShowHidden=1

" Automatically open NERDTree
autocmd vimenter * NERDTree
autocmd vimenter * wincmd p

set colorcolumn=120

set bg=dark
set go=a
set mouse=a
set nohlsearch
set clipboard=unnamedplus
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

if exists('gnvim')
        set guifont=SauceCodePro\ Nerd\ Font\ Mono\ Regular:h14
endif

command! Reindent %s/^\s*/&&

" FINDING FILES:
" Search down into subfolders
" Provides tab-completion for all file-related  tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" Use * to make it fuzzy

" THINGS TO CONSIDER:
" :b lets you autocomplete any open buffer

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames
" - ^x^] for tags only
" - ^x^o for omni completion
" - ^n for anything specified by the 'complete' option

" Some basics:
		nnoremap c "_c
		set nocompatible
		filetype plugin on
		syntax on
		set encoding=utf-8
		set number relativenumber
" Enable autocompletion:
		set wildmode=longest,list,full
" Disables automatic commenting on newline:
		autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
		map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
		map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
		set splitbelow splitright

" Nerd tree
		map <leader>n :NERDTreeToggle<CR>
		" Close NERDTree if it's the only window left
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimling:
		nm <leader>d :call ToggleDeadKeys()<CR>
		imap <leader>d <esc>:call ToggleDeadKeys()<CR>a
		nm <leader>i :call ToggleIPA()<CR>
		imap <leader>i <esc>:call ToggleIPA()<CR>a
		nm <leader>q :call ToggleProse()<CR>

" Shortcutting split navigation, saving a keypress:
		map <C-h> <C-w>h
		map <C-j> <C-w>j
		map <C-k> <C-w>k
		map <C-l> <C-w>l

" Replace all is aliased to S.
		nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
		map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
		map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
		autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
		let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
		let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
		autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
		autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
		autocmd BufRead,BufNewFile *.tex set filetype=tex

" Copy selected text to system clipboard (requires gvim/nvim/vim-x11 installed):
		vnoremap <C-c> "+y
		map <C-p> "+P

" Enable Goyo by default for mutt writting
		" Goyo's width will be the line limit in mutt.
		autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
		autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Automatically deletes all trailing whitespace on save.
		autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
		autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Run xrdb whenever Xdefaults or Xresources are updated.
		autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
