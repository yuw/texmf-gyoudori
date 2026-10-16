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

ctan:
	mkdir -p tmp/$(dir)/doc
	cp $(docdir)/$(dir)-fig.tex tmp/$(dir)/doc
	for d in $(docs); do cp $(docdir)/$$d.tex $(docdir)/$$d.pdf tmp/$(dir)/doc; done
	cp -a tex/latex/$(dir) tmp/$(dir)/tex
	cp README.md LICENSE tmp/$(dir)
	cd tmp; zip -r $(dir).zip $(dir)
	mv tmp/$(dir).zip .
	rm -r tmp

.PHONY: all status doc ctan
