if exists("g:loaded_hexrgba")
  finish
endif
let g:loaded_hexrgba = 1

let s:rgb_capture_pattern = '\(\d\+\), \?\(\d\+\), \?\(\d\+\)'
let s:hex_capture_pattern = '.*#\(\x\{2}\)\(\x\{2}\)\(\x\{2}\)'
let s:rgb_replace_pattern = 'rgba\?(.*)'
let s:hex_replace_pattern = '#\x\{6}'

function! hexrgba#ToggleHexRgba(line)
  let l:contents = getline(a:line)

  let l:hex_array = s:FetchHex(l:contents)
  if len(l:hex_array) > 0
    let l:replacement = s:convertHexToRgba(l:hex_array)
    exec a:line . "," . a:line . "s/" . s:hex_replace_pattern . "/" . l:replacement . "/g"
    return
  endif

  let l:rgba_array = s:FetchRgba(l:contents)
  if len(l:rgba_array) > 0
    let l:replacement = s:convertRgbaToHex(l:rgba_array)
    exec a:line . "," . a:line . "s/" . s:rgb_replace_pattern . "/" . l:replacement . "/g"
  endif
endfunction

function! s:convertRgbaToHex(contents)
    let l:firstHex = s:DecimalToHex(a:contents[0])
    let l:secondHex = s:DecimalToHex(a:contents[1])
    let l:thirdHex = s:DecimalToHex(a:contents[2])

    return "#" . l:firstHex . l:secondHex . l:thirdHex
endfunction

function! s:convertHexToRgba(contents)
    let l:first = str2nr(a:contents[0], 16)
    let l:second = str2nr(a:contents[1], 16)
    let l:third = str2nr(a:contents[2], 16)

    return "rgba(". l:first .", ". l:second .", ". l:third .", 1)"
endfunction

" Returns a list of decimal numbers. One for each RGB value
" :echo s:FetchRgba("color: rgba(255, 255, 255, 0.1)")
" ['255', '255', '255']
function! s:FetchRgba(line_contents)
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

