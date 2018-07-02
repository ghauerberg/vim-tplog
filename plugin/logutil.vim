" s: script local
" l: local to function
" g: global

function! s:selectPBR()
  let l:start = searchpos('<?xml', 'bW', 1, 1000)
  execute "normal! v/<\\/ns1:PBR>\<cr>f>"
endfunction

function! s:selectLinesPBR()
  " Put guard into check if xml document is a PBR
  let l:start = searchpos('<?xml', 'bW', 1, 1000)
  execute "normal! /<\\/ns1:PBR>/s\<cr>Vn"
endfunction

function! s:findAndCollapsPBR() 
  " Search forward for pbr start xml
  let l:start = searchpos('<ns1:PBR','W') 
  call s:selectLinesPBR()
  execute "normal! zf"
endfunction

function! g:CollapsAllPBR() 
  " Save the cursor position
  let l:saved_pos = getpos(".")

  " Move to the start of the file
  execute "normal! gg"


  let s:match_on_line = search('<ns1:PBR','Wp')
  while s:match_on_line == 1 
      silent! execute "normal! V/ns1:PBR>\<cr>zf"
      let s:match_on_line = search('<ns1:PBR','Wp')
  endwhile
  " Loop to end of file
  call setpos('.', l:saved_pos)
  
endfunction

" decode hex under cursor
function! g:DecodeHexBlock()
  execute "normal! $bi\<cr>\<esc>"
  let s:line = getline('.')
  let s:decodeText = system('echo '.s:line. ' | xxd -r -p')
  execute "normal! S". s:decodeText ."\<esc>0"
endfunction

function! g:DecodeBase64Block()
  let s:line = getline('.')
  let s:decodeText = system('echo '.s:line. ' | base64 -D')
  execute "normal! S". s:decodeText ."\<esc>0"
endfunction

command! SelectPBR call s:selectPBR()
command! SelectFullPBR call s:selectLinesPBR()
command! FindAndCollapsPBR call s:findAndCollapsPBR()
command! CollapsALLPBR call g:CollapsAllPBR()
command! DecodeHEX call g:DecodeHexBlock()
command! DecodeBase64 call g:DecodeBase64Block()

nnoremap <leader>l :FindAndCollapsPBR<cr>
