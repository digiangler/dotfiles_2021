"=============================================================================
" Title       : SpaceVim
" Description : My Custom SpaceVim Settings
" Author      : H.Y.
" LastUpdate  : 2021/05/16
" Since       : 2021/04/24
" Copyright   : © 2021 Digi-Angler
" License     : MIT License
" Version     : 1.0
"=============================================================================

"=============================================================================
" My Custom Vim Settings
"=============================================================================
function! myspacevim#after() abort

  "=============================================================================
  " Sneak
  "=============================================================================
  map s <Plug>Sneak_s
  map S <Plug>Sneak_S

  "=============================================================================
  " Custom Autocommands
  "=============================================================================
  fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endfun

  augroup FOSS_KING
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
  augroup END

  :echo exists('##TextYankPost')

  "=============================================================================
  " Coc-Prettier Settings
  "=============================================================================
  command! -nargs=0 Prettier :CocCommand prettier.formatFile

  "=============================================================================
  " COC Settings
  "=============================================================================
  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
  else
    set signcolumn=yes
  endif

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  "=============================================================================
  " Coc Snippets
  "=============================================================================
  " Use <C-l> for trigger snippet expand.
  imap <C-l> <Plug>(coc-snippets-expand)

  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <C-j> <Plug>(coc-snippets-select)

  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <C-j> <Plug>(coc-snippets-expand-jump)

  " Use <leader>x for convert visual selected code to snippet
  xmap <leader>x  <Plug>(coc-convert-snippet)

  "=============================================================================
  " Mappings for CoCList (what's shown with the Space key...)
  "=============================================================================
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>A  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <space>E  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent><nowait> <space>C  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  nnoremap <silent><nowait> <space>S  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <space>P  :<C-u>CocListResume<CR>hh

  "=============================================================================
  " FZF
  "=============================================================================
  map <C-f> :Files<CR>
  map <C-h> :History<CR>
  map <C-g> :RG<CR>
  map <C-s> :BLines<CR>
  map <C-a> :Lines<CR>
  map <C-b> :Buffers<CR>
  nnoremap <leader>g :Rg<CR>
  nnoremap <leader>t :Tags<CR>
  nnoremap <leader>m :Marks<CR>
  let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
  let $FZF_DEFAULT_COMMAND="rg --files --hidden"
  "Get Files
  command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


  " Get text in files with Rg
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   fzf#vim#with_preview(), <bang>0)

  " Ripgrep advanced
  function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
  endfunction

  command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

  " Git grep
  command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \   'git grep --line-number '.shellescape(<q-args>), 0,
    \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

  "=============================================================================
  " NERDTree
  "=============================================================================
  " Uncomment to autostart the NERDTree
  " autocmd vimenter * NERDTree
  map <C-n> :NERDTreeToggle<CR>
  let g:NERDTreeDirArrowExpandable = '►'
  let g:NERDTreeDirArrowCollapsible = '▼'
  let NERDTreeShowLineNumbers=1
  let NERDTreeShowHidden=1
  let NERDTreeMinimalUI = 1
  let g:NERDTreeWinSize=38

endfunction



"=============================================================================
" More Custom Vim Settings
"=============================================================================
function! myspacevim#before() abort

"=============================================================================
" Personal Settings
"=============================================================================
  " scriptencoding utf-8

  set autoindent
  " set autoread
  " set background=dark
  " set backspace=indent,eol,start
  " set backupskip=/tmp/*,/private/tmp/*
  " set clipboard&
  " set clipboard=unnamed,unnamedplus
  " set cmdheight=2
  " set confirm
  " set cursorline
  " set cursorcolumn
  " set enc=utf-8
  set encoding=utf-8
  " set expandtab
  " set fenc=utf-8
  " set helpheight=999
  " set hidden
  set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp,sjis,latin
  set fileformats=unix,dos,mac
  " set gdefault
  set helplang=ja,en
  set history=10000
  " set hlsearch
  " set ignorecase
  " set inccommand=split
  set incsearch
  " set laststatus=2
  set linebreak
  " set list
  " set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮
  set mouse=a
  set nobackup
  set noswapfile
  " set nowritebackup
  " set number
  " set relativenumber
  " set scrolloff=10
  " set shellslash
  " set shell=fish
  " set shiftwidth=2
  set shortmess+=c
  " set showcmd
  " set showmatch
  " set sidescroll=1
  " set sidescrolloff=16
  set signcolumn=yes
  " set smartcase
  " set smartindent
  " set smarttab
  " set softtabstop=2
  " set tabstop=2
  " set termguicolors
  set textwidth=80
  " set title
  set updatetime=100
  " set visualbell
  " set virtualedit=onemore
  " set whichwrap=b,s,h,l,<,>,[,],~
  " set wildmode=list:longest
  set wrap
  " set wrapscan

"=============================================================================
" Custom Keybindings
"=============================================================================





  "=============================================================================
  " Airline
  "=============================================================================
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:shades_of_purple_airline = 1
  let g:airline_theme='shades_of_purple'
  let g:airline#extensions#coc#enabled = 1
  let g:airline_section_x = '%{ScrollStatus()} '

  "=============================================================================
  " ScrollStatus
  "=============================================================================
  let g:scrollstatus_size = 12
  let g:scrollstatus_symbol_track = '-'
  let g:scrollstatus_symbol_bar = '|'

  "=============================================================================
  " Vim Rainbow
  "=============================================================================
  let g:rainbow_active = 1

  "=============================================================================
  " Startify
  "=============================================================================
  let g:startify_custom_indices = map(range(10,100), 'string(v:val)')
  let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   Recently Opened Files']            },
            \ { 'type': 'sessions',  'header': ['   My Sessions']       },
            \ { 'type': 'bookmarks', 'header': ['   My Bookmarks']      },
            \ ]
  let g:startify_bookmarks = [
              \ { 'm': '~/.SpaceVim.d/autoload/myconfig.vim' },
              \ { 'i': '~/.SpaceVim.d/init.toml'},
              \ { 's': '~/.SpaceVim/autoload/SpaceVim.vim'},
              \ { 'k': '~/.config/kitty/kitty.conf'},
              \ { 'f': '~/.config/fish/config.fish'},
              \ { 'a': '~/apps.txt'},
              \ { 't': '~/Documents/test.sh'},
              \ ]

  "=============================================================================
  " COC-Snippets
  "=============================================================================
  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<tab>'

  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<s-tab>'

  "=============================================================================
  " FZF
  "=============================================================================
  " This is the default extra key bindings
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

  " Enable per-command history.
  " CTRL-N and CTRL-P will be automatically bound to next-history and
  " previous-history instead of down and up. If you don't like the change,
  " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
  let g:fzf_history_dir = '~/.local/share/fzf-history'
  let g:fzf_tags_command = 'ctags -R'
  " Border color
  let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
  " Customize fzf colors to match your color scheme
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  "=============================================================================

endfunction
