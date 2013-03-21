" Following lines added by drush vimrc-install on Sat, 23 Feb 2013 09:51:03 +0000.
set nocompatible
call pathogen#infect('/Users/alanjosephburke/.drush/vimrc/bundle')
call pathogen#infect('/Users/alanjosephburke/.vim/bundle')
" End of vimrc-install additions.
" Allow Vim-only settings even if they break vi keybindings.
set nocompatible

" Always edit in utf-8:
set encoding=utf-8

" Enable filetype detection
filetype plugin on

" General settings
set incsearch               "Find as you type
set scrolloff=2             "Number of lines to keep above/below cursor
set number                  "Show line numbers
set wildmode=longest,list   "Complete longest string, then list alternatives
set fileformats=unix        "Use Unix line endings
set history=300             "Number of commands to remember
set showmode                "Show whether in Visual, Replace, or Insert Mode
set showmatch               "Show matching brackets/parentheses
set backspace=2             "Use standard backspace behavior
set hlsearch                "Highlight matches in search
set ruler                   "Show line and column number
set formatoptions=1         "Don't wrap text after a one-letter word
set linebreak               "Break lines when appropriate

" Persistent Undo (vim 7.3 and later)
if exists('&undofile') && !&undofile
  set undodir=~/.vim_runtime/undodir
  set undofile
endif

" Drupal settings
let php_htmlInStrings = 1   "Syntax highlight for HTML inside PHP strings
let php_parent_error_open = 1 "Display error for unmatch brackets

" Enable syntax highlighting
if &t_Co > 1
  syntax enable
endif
syntax on

" When in split screen, map <C-LeftArrow> and <C-RightArrow> to switch panes.
nn [5C <C-W>w
nn [5R <C-W>W

" Custom key mapping
map <S-u> :redo<cr>
map <C-n> :tabn<cr>
map <C-p> :tabp<cr>

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
 au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
 \| exe "normal! g'\"" | endif
endif

" Highlight long comments and trailing whitespace.
" It is not good practice to include syntax items in a plugin file, but we do
" it here, with Syntax autocommands, because syntax files do not follow the
" same naming conventions as ftplugin files, so we cannot use (for example)
" syntax/php_drupal.vim .
" Adapted from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight default link drupalExtraWhitespace Error
highlight default link drupalOverLength Error
augroup Drupal
  " Remove ALL autocommands for the Drupal group.
  autocmd!
  autocmd Syntax php syn match drupalOverLength "\%81v.*" containedin=phpComment contained
  autocmd Syntax css syn match drupalOverLength "\%81v.*" containedin=cssComment contained
  autocmd BufWinEnter * call s:ToggleWhitespaceMatch('BufWinEnter')
  autocmd BufWinLeave * call s:ToggleWhitespaceMatch('BufWinLeave')
  autocmd InsertEnter * call s:ToggleWhitespaceMatch('InsertEnter')
  autocmd InsertLeave * call s:ToggleWhitespaceMatch('InsertLeave')
augroup END
function! s:ToggleWhitespaceMatch(event)
  if &ft != 'php' && &ft != 'css'
    return
  endif
  if a:event == 'BufWinEnter'
    let w:whitespace_match_number = matchadd('drupalExtraWhitespace', '\s\+$')
    return
  endif
  if !exists('w:whitespace_match_number')
    return
  endif
  call matchdelete(w:whitespace_match_number)
  if a:event == 'BufWinLeave'
    unlet w:whitespace_match_number
  elseif a:event == 'InsertEnter'
    call matchadd('drupalExtraWhitespace', '\s\+\%#\@<!$', 10, w:whitespace_match_number)
  elseif a:event == 'InsertLeave'
    call matchadd('drupalExtraWhitespace', '\s\+$', 10, w:whitespace_match_number)
  endif
endfunction
" Source the default ftplugin so that it does not change our settings.
" Specifically, the 'comments' option gets clobbered by html.vim.
runtime! ftplugin/php.vim

" Get common settings and mappings for Drupal.
source <sfile>:h/.vim/plugin/drupal.vim

setl ignorecase              "Ignore case in search
setl smartcase               "Only ignore case when all letters are lowercase
setl comments=sr:/**,m:*\ ,ex:*/,://
"  Format comment blocks.  Just type / on a new line to close.
"  Recognize // (but not #) style comments.

" tab navigation like firefox

:map <S-h> gT
:map <S-l> gt

"folding settings
set foldmethod=syntax   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use
set pastetoggle=<F2>
set paste
