command! -range Convert <line1>,<line2>!echo "`cat`" | guile  -s converter.scm --no-auto-compile
command! -nargs=1 DirtyConvert s@<!--\([^-]*\)-->@<span id="<args>" data-endon="\1">\r\n</span>@

