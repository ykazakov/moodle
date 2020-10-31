PREFIX=test
SUFFIX=moodle
TEST_FILES=$(wildcard $(PREFIX)_*.tex)
LATEX=latex
PDFLATEX=lualatex
LATEXFLAGS=-interaction=nonstopmode -shell-escape
DIFFTOOL=diff -abBwZ
FILE_CLEAN=*.sty *.log *.aux *.auxlock *.out *.blg *.bbl *.toc *.xml *.bcf *.synctex.gz *~ *.nav *.snm *.idx *.ilg *.ind _minted-* *.glo *.gls *.dpth *-tikztemp-*.pdf
ifndef DEBUG
	DEBUG=> /dev/null
endif

.DEFAULT_GOAL := all

.PHONY: all test clean distclean references

all: test

test: $(TEST_FILES:.tex=-$(SUFFIX).xml) $(TEST_FILES:.tex=.diff)

references: $(TEST_FILES:.tex=-$(SUFFIX).ref)

clean:
	rm -rf $(FILE_CLEAN)

distclean: clean
	rm -rf *.pdf *.xml *.diff *.md5 *.py *.err $(SUFFIX).sty

%-$(SUFFIX).xml : %.tex $(SUFFIX).sty
	@$(PDFLATEX) $(LATEXFLAGS) $< $(DEBUG)

OK = "$$(tput setaf 0)$$(tput setab 2)[  OK  ]$$(tput sgr0)"
KO = "$$(tput setaf 0)$$(tput setab 1)[FAILED]$$(tput sgr0)"
$(PREFIX)_%.diff : $(PREFIX)_%-$(SUFFIX).ref $(PREFIX)_%-$(SUFFIX).xml
	@$(DIFFTOOL) $(basename $<).xml $< > $@ && echo "$(OK) $*"  | sed -e "s/_/ /g" || echo "$(KO) $*" | sed -e "s/_/ /g"

# DISABLING THE FOLLOWING FOR SAFETY
# BE SURE OF THE CODE PRODUCED IF YOU UNCOMMENT
#%.ref : %.xml
#	@cp $< $@

$(SUFFIX).sty: ../$(SUFFIX).sty
	cp $< $@
../$(SUFFIX).sty: ../$(SUFFIX).dtx
	$(MAKE) -C ../ moodle.sty
