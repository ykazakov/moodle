PREFIX=test
SUFFIX=moodle
DONOTTEST_THOSE_FILES=test_calculated_python.tex test_generalfeedback.tex test_includegraphics_via_tikz.tex test_minted.tex test_diacritics_and_ligatures.tex test_german.tex test_includegraphics_via_tikz_and_svg.tex test_punctuation_and_symbols.tex test_turkish.tex test_french.tex test_includegraphics.tex test_includegraphics_with_svg.tex test_tikz_with_svg.tex test_tolerance.tex
PDFLATEX_EXCLUDED_TEST_FILES=$(DONOTTEST_THOSE_FILES) test_calculated_lua.tex
XETEX_EXCLUDED_TEST_FILES=$(DONOTTEST_THOSE_FILES) test_calculated_lua.tex
LUATEX_EXCLUDED_TEST_FILES=$(DONOTTEST_THOSE_FILES) test_calculated_lua.tex test_tags.tex
ALL_TEST_FILES=$(wildcard $(PREFIX)_*.tex)
PDFLATEX_TEST_FILES = $(filter-out $(PDFLATEX_EXCLUDED_TEST_FILES),$(ALL_TEST_FILES))
XETEX_TEST_FILES = $(filter-out $(XETEX_EXCLUDED_TEST_FILES),$(ALL_TEST_FILES))
LUATEX_TEST_FILES = $(filter-out $(LUATEX_EXCLUDED_TEST_FILES),$(ALL_TEST_FILES))
TEX_ENGINES=pdflatex xelatex lualatex
LATEXFLAGS=-halt-on-error -shell-escape
DIFFTOOL=diff -abBwZ
FILE_CLEAN=*.diff *.log *.aux *.auxlock *.out *.blg *.bbl *.toc *.xml *.bcf *.synctex.gz *~ *.nav *.snm *.idx *.ilg *.ind _minted-* *.glo *.gls *.dpth *-tikztemp-*.pdf fig/*-converted-to.*
ifndef DEBUG
	DEBUG=> /dev/null
endif

.DEFAULT_GOAL := all
.NOTPARALLEL := test

.PHONY: all test clean distclean $(TEX_ENGINES)
.SECONDARY: $(foreach engine,$(TEX_ENGINES),$(PDFLATEX_TEST_FILES:.tex=_pdflatex-$(SUFFIX).xml) $(XETEX_TEST_FILES:.tex=_pdflatex-$(SUFFIX).xml) $(LUATEX_TEST_FILES:.tex=_pdflatex-$(SUFFIX).xml))

all: test

test: $(TEX_ENGINES)

pdflatex: $(PDFLATEX_TEST_FILES:.tex=_pdflatex.diff)

xelatex: $(XETEX_TEST_FILES:.tex=_xelatex.diff)

lualatex: $(LUATEX_TEST_FILES:.tex=_lualatex.diff)

clean:
	rm -rf $(FILE_CLEAN)

distclean: clean
	rm -rf *.pdf *.xml *.diff *.md5 *.py *.err $(SUFFIX).sty

%_pdflatex-$(SUFFIX).xml : %.tex $(SUFFIX).sty
	@pdflatex $(LATEXFLAGS) $< $(DEBUG)
	@mv $(basename $<)-$(SUFFIX).xml $@

%_xelatex-$(SUFFIX).xml : %.tex $(SUFFIX).sty
	@xelatex $(LATEXFLAGS) $< $(DEBUG)
	@mv $(basename $<)-$(SUFFIX).xml $@

%_lualatex-$(SUFFIX).xml : %.tex $(SUFFIX).sty
	@lualatex $(LATEXFLAGS) $< $(DEBUG)
	@mv $(basename $<)-$(SUFFIX).xml $@

OK = "$$(tput setaf 0)$$(tput setab 2)[  OK  ]$$(tput sgr0)"
KO = "$$(tput setaf 0)$$(tput setab 1)[FAILED]$$(tput sgr0)"
$(PREFIX)_%_pdflatex.diff : latin1ref/$(PREFIX)_%-$(SUFFIX).ref $(PREFIX)_%_pdflatex-$(SUFFIX).xml
	@$(DIFFTOOL) $^ > $@ && echo "$(OK) $* (pdflatex)"  | sed -e "s/_/ /g" || echo "$(KO) $* (pdflatex)" | sed -e "s/_/ /g"

$(PREFIX)_%_xelatex.diff : utf8ref/$(PREFIX)_%-$(SUFFIX).ref $(PREFIX)_%_xelatex-$(SUFFIX).xml
	@$(DIFFTOOL) $^ > $@ && echo "$(OK) $* (xelatex)"  | sed -e "s/_/ /g" || echo "$(KO) $* (xelatex)" | sed -e "s/_/ /g"
	
$(PREFIX)_%_lualatex.diff : utf8ref/$(PREFIX)_%-$(SUFFIX).ref $(PREFIX)_%_lualatex-$(SUFFIX).xml
	@$(DIFFTOOL) $^ > $@ && echo "$(OK) $* (lualatex)"  | sed -e "s/_/ /g" || echo "$(KO) $* (lualatex)" | sed -e "s/_/ /g"

$(SUFFIX).sty: ../$(SUFFIX).sty
	cp $< $@
../$(SUFFIX).sty: ../$(SUFFIX).dtx
	$(MAKE) -C ../ $(SUFFIX).sty
