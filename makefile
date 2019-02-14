FILE_CLEAN=*.sty *.log *.aux *.auxlock *.out *.blg *.bbl *.toc *.xml *.bcf *.synctex.gz *~ *.nav *.snm *.idx *.ilg *.ind _minted-*
ifndef DEBUG
	DEBUG=> /dev/null
endif

.DEFAULT_GOAL := all

.PHONY: all diff clean distclean

all: MWE.pdf diff

clean:
	rm -rf $(FILE_CLEAN)

distclean: clean
	rm -rf *.pdf *.xml

diff: moodle.sty moodle_v5.sty
	meld moodle.sty moodle_v5.sty

MWE.pdf: moodle.sty

%.pdf: %.tex
	pdflatex $< $(DEBUG)

%.sty: %.ins
	latex $< $(DEBUG)
