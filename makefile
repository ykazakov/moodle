FILE_CLEAN=*.sty *.log *.aux *.auxlock *.out *.blg *.bbl *.toc *.xml *.bcf *.synctex.gz *~ *.nav *.snm *.idx *.ilg *.ind _minted-* *.glo *.gls
LATEX=latex
PDFLATEX=pdflatex
LATEXFLAGS=-interaction=nonstopmode -shell-escape
DIFFTOOL=meld
MAKEINDEX=makeindex
ifndef DEBUG
	DEBUG=> /dev/null
endif

.DEFAULT_GOAL := all

.PHONY: all diff clean distclean

all: example_quiz.pdf example_quiz_v5.pdf moodle.pdf

clean:
	rm -rf $(FILE_CLEAN)

distclean: clean
	rm -rf *.pdf *.xml

diff: moodle.sty moodlev5.sty
	$(DIFFTOOL) moodle.sty moodlev5.sty

moodle.sty: moodle.dtx

moodlev5.sty: moodlev5.dtx

example_quiz.pdf: moodle.sty

example_quiz_v5.pdf: moodlev5.sty

moodle.pdf: moodle.dtx moodle.gls
	$(PDFLATEX) $< $(DEBUG)

moodlev5.pdf: moodlev5.dtx
	$(PDFLATEX) $< $(DEBUG)

%.glo: %.dtx
	$(PDFLATEX) $< $(DEBUG)

%.gls: %.glo
	$(MAKEINDEX) -s gglo.ist -o $@ $< $(DEBUG)

%.pdf: %.tex
	$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)

%.sty: %.ins
	rm -rf $@
	$(LATEX) $(LATEXFLAGS) $< $(DEBUG)
