PREFIX=test_
SUFFIX=-moodle
TEST_FILES=$(wildcard $(PREFIX)*.tex)
LATEX=latex
PDFLATEX=xelatex
LATEXFLAGS=-interaction=nonstopmode -shell-escape
DIFFTOOL=diff -abBwZ
FILE_CLEAN=*.sty *.log *.aux *.auxlock *.out *.blg *.bbl *.toc *.xml *.bcf *.synctex.gz *~ *.nav *.snm *.idx *.ilg *.ind _minted-* *.glo *.gls *.dpth
ifndef DEBUG
	DEBUG=> /dev/null
endif

.DEFAULT_GOAL := all

.PHONY: all test clean distclean references

all: test

test: $(TEST_FILES:.tex=$(SUFFIX).xml) $(TEST_FILES:.tex=.diff)

references: $(TEST_FILES:.tex=$(SUFFIX).ref)

clean:
	rm -rf $(FILE_CLEAN)

distclean: clean
	rm -rf *.pdf *.xml *.diff

%$(SUFFIX).xml : %.tex ../moodle.sty
	@$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)

$(PREFIX)%.diff : $(PREFIX)%$(SUFFIX).ref $(PREFIX)%$(SUFFIX).xml
	@$(DIFFTOOL) $(basename $<).xml $< > $@ && echo 'OK   <- $*' || echo 'FAIL <- $*'

# DISABLING THE FOLLOWING FOR SAFETY
# BE SURE OF THE CODE PRODUCED IF YOU UNCOMMENT
#%.ref : %.xml
#	@cp $< $@

../moodle.sty:
	$(MAKE) -C ../ moodle.sty
