if exists("g:loaded_hexrgb")
  finish
endif
let g:loaded_hexrgb = 1

let s:rgb_capture_pattern = '\(\d\+\), \?\(\d\+\), \?\(\d\+\)'
let s:hex_capture_pattern = '.*#\(\x\{2}\)\(\x\{2}\)\(\x\{2}\)'
let s:rgb_replace_pattern = 'rgba\?(.*)'
let s:hex_replace_pattern = '#\x\{6}'

function! hexrgba#ToggleHexRgba(line)
  let l:contents = getline(a:line)

  let l:input = s:FetchHex(l:contents)
  if len(l:input) > 0
    let l:first = str2nr(l:input[0], 16)
    let l:second = str2nr(l:input[1], 16)
    let l:third = str2nr(l:input[2], 16)

    let l:replacement = "rgba(". l:first .", ". l:second .", ". l:third .", 1)"
    exec a:line . "," . a:line . "s/" . s:hex_replace_pattern . "/" . l:replacement . "/g"
    return
  endif

  let l:input = s:FetchRgb(l:contents)
  if len(l:input) > 0
    let l:firstHex = s:DecimalToHex(l:input[0])
    let l:secondHex = s:DecimalToHex(l:input[1])
    let l:thirdHex = s:DecimalToHex(l:input[2])

    let l:replacement = "#" . l:firstHex . l:secondHex . l:thirdHex
    exec a:line . "," . a:line . "s/" . s:rgb_replace_pattern . "/" . l:replacement . "/g"
  endif
endfunction

" Returns a list of decimal numbers. One for each RGB value
" :echo s:FetchRgb("color: rgba(255, 255, 255, 0.1)")
" ['255', '255', '255']
function! s:FetchRgb(line_contents)
  let l:matches = matchlist(a:line_contents, s:rgb_capture_pattern)
  return l:matches[1:3]
endfunction

" Returns a list of hex numbers. One for each RGB value
" :echo s:FetchHex("color: #AABBCC;")
" ['AA', 'BB', 'CC']
function! s:FetchHex(line_contents)
  let l:matches = matchlist(a:line_contents, s:hex_capture_pattern)
  return l:matches[1:3] " Only return the 3 hex matches
endfunction


function! s:DecimalToHex(string_number)
  return toupper(printf("%02x", str2nr(a:string_number)))
endfunction

command! HexRgba :call hexrgba#ToggleHexRgba(".")

