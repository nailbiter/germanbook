.PHONY: all push
all: text1.html text2.html
#text1.html: text1_proto.html converter.scm
#	guile -s converter.scm text1_proto.html > text1.html
text2.html: text2_proto.html converter.scm
	guile -s converter.scm text2_proto.html > text2.html

push:
	git commit -a -m "commit"
	git push

