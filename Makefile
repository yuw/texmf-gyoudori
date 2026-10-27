dir = gyoudori
docdir = doc/$(dir)
docs = $(dir)-ja $(dir)-en

all: status

status:
	git status .

# マニュアル（pLaTeX＋dvipdfmx）
doc:
	for d in $(docs); do \
	  (cd $(docdir) && \
	   TEXINPUTS=../../tex/latex/$(dir)//: platex $$d && \
	   TEXINPUTS=../../tex/latex/$(dir)//: platex $$d && \
	   dvipdfmx $$d && \
	   rm -f $$d.aux $$d.log $$d.dvi) || exit 1; \
	done

# CTANに出すアーカイブ（build/ctan/gyoudori.zip）．中身はtools/ctan/mkctan.shを参照
ctan:
	sh tools/ctan/mkctan.sh

.PHONY: all status doc ctan
