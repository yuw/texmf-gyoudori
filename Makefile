dir = gyoudori
docdir = doc/$(dir)

all: status

status:
	git status .

# マニュアル（pLaTeX＋dvipdfmx）
doc:
	cd $(docdir); TEXINPUTS=../../tex/latex/$(dir)//: platex $(dir)-ja
	cd $(docdir); TEXINPUTS=../../tex/latex/$(dir)//: platex $(dir)-ja
	cd $(docdir); dvipdfmx $(dir)-ja
	cd $(docdir); rm -f $(dir)-ja.aux $(dir)-ja.log $(dir)-ja.dvi

ctan:
	mkdir -p tmp/$(dir)/doc
	cp $(docdir)/$(dir)-ja.tex $(docdir)/$(dir)-ja.pdf tmp/$(dir)/doc
	cp -a tex/latex/$(dir) tmp/$(dir)/tex
	cp README.md tmp/$(dir)
	cd tmp; zip -r $(dir).zip $(dir)
	mv tmp/$(dir).zip .
	rm -r tmp

.PHONY: all status doc ctan
