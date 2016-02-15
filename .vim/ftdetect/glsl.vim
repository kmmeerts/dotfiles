command SetGLSLFileType call SetGLSLFileType()
function SetGLSLFileType()
  execute ':set filetype=glsl'
  for item in getline(1,10)
    if item =~ "#version 400"
      execute ':set filetype=glsl400'
      break
    endif
    if item =~ "#version 330"
      execute ':set filetype=glsl330'
      break
    endif
  endfor
endfunction

au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl SetGLSLFileType
