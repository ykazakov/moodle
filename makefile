PROJECT_NAME=moodle
FILE_CLEAN=*.sty *.log *.aux *.auxlock *.out *.blg *.bbl *.toc *.xml *.bcf *.synctex.gz *~ *.nav *.snm *.idx *.ilg *.ind _minted-* *.glo *.gls *.dpth
LATEX=latex
PDFLATEX=lualatex
LATEXFLAGS=-interaction=nonstopmode -shell-escape
DIFFTOOL=meld
MAKEINDEX=makeindex
TESTDIR=test
RECURSIVE_TARGETS= all clean distclean test
RERUNLATEX= '(There were undefined references|Rerun to get (cross-references|the bars) right)'

ifndef DEBUG
	DEBUG=> /dev/null
endif

.DEFAULT_GOAL := all

.PHONY: all diff clean distclean test dist

all: example_quiz.pdf example_quiz_v5.pdf $(PROJECT_NAME).pdf $(TESTDIR)/all

clean: $(TESTDIR)/clean
	rm -rf $(FILE_CLEAN)

distclean: clean

distclean: $(TESTDIR)/distclean
	rm -rf *.pdf *.xml

diff: $(PROJECT_NAME).sty $(PROJECT_NAME)v5.sty
	$(DIFFTOOL) $(PROJECT_NAME).sty $(PROJECT_NAME)v5.sty

test: $(TESTDIR)/test

dist: $(PROJECT_NAME).pdf $(PROJECT_NAME).sty test
	@$(MAKE) distclean -C $(TESTDIR)
	@zip -r9 moodle_$(shell date +"%Y-%m-%d").zip $(PROJECT_NAME).pdf $(PROJECT_NAME).sty $(PROJECT_NAME).dtx $(PROJECT_NAME).ins makefile README.md test/
	@$(MAKE) clean -C .

$(PROJECT_NAME).sty: $(PROJECT_NAME).dtx

$(PROJECT_NAME)v5.sty: $(PROJECT_NAME).dtx

example_quiz.pdf: $(PROJECT_NAME).sty

example_quiz_v5.pdf: $(PROJECT_NAME)v5.sty

$(PROJECT_NAME).pdf: $(PROJECT_NAME).dtx $(PROJECT_NAME).gls

$(PROJECT_NAME)v5.pdf: $(PROJECT_NAME)v5.dtx

%.glo: %.dtx
	$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)

%.gls: %.glo
	$(MAKEINDEX) -s gglo.ist -o $@ $< $(DEBUG)

%.pdf: %.tex
	$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)

%.pdf: %.dtx
	$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)
	@if egrep -q $(RERUNLATEX) $(basename $@).log ; then \
		echo "\trequires a new $(PDFLATEX) pass..."; \
		$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG); \
	fi

%.sty: %.ins
	rm -rf $@
	$(LATEX) $(LATEXFLAGS) $< $(DEBUG)
	
$(RECURSIVE_TARGETS:%=$(TESTDIR)/%) :
	@$(MAKE) $(notdir $@) -C $(dir $@)
