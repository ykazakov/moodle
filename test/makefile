PREFIX=test
SUFFIX=moodle
LUATEX_ONLY_TEST_FILES=test_calculated_lua.tex
XETEX_EXCLUDED_TEST_FILES=test_calculated_python.tex test_generalfeedback.tex test_includegraphics_via_tikz.tex test_minted.tex test_diacritics_and_ligatures.tex test_german.tex test_includegraphics_via_tikz_and_svg.tex test_punctuation_and_symbols.tex test_turkish.tex test_french.tex test_includegraphics.tex test_includegraphics_with_svg.tex test_tikz_with_svg.tex test_tolerance.tex
PDFLATEX_EXCLUDED_TEST_FILES=test_calculated_python.tex test_generalfeedback.tex test_includegraphics_via_tikz.tex test_minted.tex test_diacritics_and_ligatures.tex test_german.tex test_includegraphics_via_tikz_and_svg.tex test_punctuation_and_symbols.tex test_turkish.tex test_french.tex test_includegraphics.tex test_includegraphics_with_svg.tex test_tikz_with_svg.tex test_tolerance.tex
GENERIC_TEST_FILES=$(filter-out $(PDFLATEX_EXCLUDED_TEST_FILES) $(LUATEX_ONLY_TEST_FILES) $(XETEX_EXCLUDED_TEST_FILES),$(wildcard $(PREFIX)_*.tex))
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
.SECONDARY: $(foreach engine,$(TEX_ENGINES),$(GENERIC_TEST_FILES:.tex=_$(engine)-$(SUFFIX).xml)) $(LUATEX_ONLY_TEST_FILES:.tex=_lualatex-$(SUFFIX).xml) $(XETEX_EXCLUDED_TEST_FILES:.tex=_pdflatex-$(SUFFIX).xml) $(XETEX_EXCLUDED_TEST_FILES:.tex=_lualatex-$(SUFFIX).xml)

all: test

test: $(TEX_ENGINES)

pdflatex: $(GENERIC_TEST_FILES:.tex=_pdflatex.diff) $(filter-out $(PDFLATEX_EXCLUDED_TEST_FILES:.tex=_pdflatex.diff),$(XETEX_EXCLUDED_TEST_FILES:.tex=_pdflatex.diff))

xelatex: $(GENERIC_TEST_FILES:.tex=_xelatex.diff) $(filter-out $(XETEX_EXCLUDED_TEST_FILES:.tex=_xelatex.diff),$(PDFLATEX_EXCLUDED_TEST_FILES:.tex=_xelatex.diff))

lualatex: $(GENERIC_TEST_FILES:.tex=_lualatex.diff) $(PDFLATEX_EXCLUDED_TEST_FILES:.tex=_lualatex.diff) $(LUATEX_ONLY_TEST_FILES:.tex=_lualatex.diff) $(XETEX_EXCLUDED_TEST_FILES:.tex=_lualatex.diff)

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
