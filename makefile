FILE_CLEAN=*.sty *.log *.aux *.auxlock *.out *.blg *.bbl *.toc *.xml *.bcf *.synctex.gz *~ *.nav *.snm *.idx *.ilg *.ind _minted-* *.glo *.gls *.dpth
LATEX=latex
PDFLATEX=pdflatex
LATEXFLAGS=-interaction=nonstopmode -shell-escape
DIFFTOOL=meld
MAKEINDEX=makeindex
TESTDIR=test
RECURSIVE_TARGETS= all clean distclean test

ifndef DEBUG
	DEBUG=> /dev/null
endif

.DEFAULT_GOAL := all

.PHONY: all diff clean distclean test

all: example_quiz.pdf example_quiz_v5.pdf moodle.pdf $(TESTDIR)/all

clean: $(TESTDIR)/clean
	rm -rf $(FILE_CLEAN)

distclean: clean

distclean: $(TESTDIR)/distclean
	rm -rf *.pdf *.xml

diff: moodle.sty moodlev5.sty
	$(DIFFTOOL) moodle.sty moodlev5.sty

test: $(TESTDIR)/test

moodle.sty: moodle.dtx

moodlev5.sty: moodlev5.dtx

example_quiz.pdf: moodle.sty

example_quiz_v5.pdf: moodlev5.sty

moodle.pdf: moodle.dtx moodle.gls

moodlev5.pdf: moodlev5.dtx

%.glo: %.dtx
	$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)

%.gls: %.glo
	$(MAKEINDEX) -s gglo.ist -o $@ $< $(DEBUG)

%.pdf: %.tex
	$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)

%.pdf: %.dtx
	$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)

%.sty: %.ins
	rm -rf $@
	$(LATEX) $(LATEXFLAGS) $< $(DEBUG)
	
$(RECURSIVE_TARGETS:%=$(TESTDIR)/%) :
	@$(MAKE) $(notdir $@) -C $(dir $@)
