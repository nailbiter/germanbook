command! -range Convert <line1>,<line2>!echo "`cat`" | guile  -s converter.scm --no-auto-compile
