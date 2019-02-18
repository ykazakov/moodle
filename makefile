FILE_CLEAN=*.sty *.log *.aux *.auxlock *.out *.blg *.bbl *.toc *.xml *.bcf *.synctex.gz *~ *.nav *.snm *.idx *.ilg *.ind _minted-*
LATEX=latex
PDFLATEX=pdflatex
LATEXFLAGS=-interaction=nonstopmode -shell-escape
DIFFTOOL=meld
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
	$(DIFFTOOL) moodle.sty moodle_v5.sty

moodle.sty: moodle.dtx

MWE.pdf: moodle.sty

%.pdf: %.tex
	$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)

%.sty: %.ins
	rm -rf $@
	$(LATEX) $(LATEXFLAGS) $< $(DEBUG)
