" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc
" To get the full range of colors in the terminal window, vim only
set t_Co=256

filetype plugin on

augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
  au BufNewFile,BufRead *.ino setfiletype cpp
  au BufNewFile,BufRead *.jinja2 setfiletype html
  au BufNewFile,BufRead *.jsx setfiletype javascript
augroup end
set ruler
" Name of the file that I am editing
" Format of the file that I am editing (DOS, Unix)
" Filetype as recognized by Vim for the current file
" ASCII and hex value of the character under the cursor
" Position in the document as row and column number
" Length of the file (line count)
" ===== For more info on the flags type :help statusline =====
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
set mouse-=a
set number
set smartcase
set ignorecase
set autoread
set autoindent
set shiftwidth=4

" Powerline config options
set nocompatible
set encoding=utf-8   "vim only


" Special character display
:set listchars=eol:»,tab:>-,trail:~,extends:>,precedes:<
:set list

"Useful mappings
" Show/hide line numbers
:nmap \l :setlocal number!<CR>
" Enable/disable paste mode (no auto tabs)
:nmap \o :set paste!<CR>
" Show/hide special characters(tabs, newlines, spaces etc)
:nmap \c :set list!<CR>
" Turn all buffers into tabs
:nmap \r :tab sball<CR>
:nmap <Leader>t :Tags<CR>
:nmap <Leader>y :YcmCompleter GetType<CR>
:nmap <Leader>b :Buffers<CR>
:xnoremap \a "+y<CR>

" Whitespace highlighting
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen ctermfg=black guifg=black
highlight AllTabs ctermbg=darkred guibg=darkred

" map ctrl-b to list currently open buffers
"nmap <C-b> :buffers<CR>:buffer<Space>

filetype on

set tabstop=4
set hlsearch
set expandtab
set backspace=indent,start

autocmd FileType make set noexpandtab
autocmd FileType css setlocal tabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType jsx setlocal tabstop=2 shiftwidth=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2


"################ PLUGINS #########################
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
"Plug 'scrooloose/syntastic'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'davidhalter/jedi-vim'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'mileszs/ack.vim'
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'adrienverge/yamllint'
Plug 'zxqfl/tabnine-vim'
call plug#end()

" Ctrl-P config
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_user_command =
"      \ ['.git', "cd %s && git ls-files . -co --exclude-standard && git submodule foreach -q \"git ls-files | sed 's|^|$path/|g'\""]

" Airline config
let g:airline_powerline_fonts = 1

" NerdTree config options
map <C-n> :NERDTreeToggle<CR>

" fzf enable
set rtp+=~/.fzf
nmap <C-p> :Files<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)

" ALE setup
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:airline#extensions#ale#enabled = 1


let g:jedi#completions_enabled = 0


" YCM extra conf
"let g:ycm_global_ycm_extra_conf = "~/code/.ycm_extra_conf.py""
"
"
"========================================
" Everything related to the backup files
"========================================
" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fine
set swapfile
set directory^=~/.vim/swap//

" protect against crash-during-write
set writebackup
" but do not persist backup after successful write
set nobackup
" use rename-and-write-new method whenever safe
set backupcopy=auto
" patch required to honor double slash at end
if has("patch-8.1.0251")
	" consolidate the writebackups -- not a big
	" deal either way, since they usually get deleted
	set backupdir^=~/.vim/backup//
end

" persist the undo tree for each file
set undofile
set undodir^=~/.vim/undo//

" shortcuts for 3-way merge
map <Leader>1 :diffget LOCAL<CR>
map <Leader>2 :diffget BASE<CR>
map <Leader>3 :diffget REMOTE<CR>

if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif
