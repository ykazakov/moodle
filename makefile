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

.PHONY: all clean distclean test dist install

all: $(PROJECT_NAME).pdf $(PROJECT_NAME).sty

clean: $(TESTDIR)/clean
	rm -rf $(FILE_CLEAN)

distclean: clean

distclean: $(TESTDIR)/distclean
	rm -rf *.pdf *.xml *.zip
	rm -rf texmf/ ./$(PROJECT_NAME)/

test: $(TESTDIR)/test

dist: test $(PROJECT_NAME).zip
	@mv $(PROJECT_NAME).zip $(PROJECT_NAME)_$(shell date +"%Y-%m-%d").zip
	@mv $(PROJECT_NAME).tds.zip $(PROJECT_NAME)_$(shell date +"%Y-%m-%d").tds.zip
	@cp $(PROJECT_NAME).pdf $(PROJECT_NAME)_$(shell date +"%Y-%m-%d").pdf
	@$(MAKE) clean -C .

$(PROJECT_NAME).zip: $(PROJECT_NAME).tds.zip $(PROJECT_NAME).pdf
	@mkdir -p ./$(PROJECT_NAME)/
	@cp $(PROJECT_NAME).dtx ./$(PROJECT_NAME)/
	@cp $(PROJECT_NAME).ins ./$(PROJECT_NAME)/
	@cp $(PROJECT_NAME).pdf ./$(PROJECT_NAME)/
	@cp README.ctan ./$(PROJECT_NAME)/README.md
	zip -r9 $(PROJECT_NAME).zip $(PROJECT_NAME).tds.zip $(PROJECT_NAME)

$(PROJECT_NAME).tds.zip : $(PROJECT_NAME).pdf $(PROJECT_NAME).sty
	@mkdir -p ./texmf/tex/latex/$(PROJECT_NAME)/
	@mkdir -p ./texmf/source/latex/$(PROJECT_NAME)/
	@mkdir -p ./texmf/doc/latex/$(PROJECT_NAME)/
	@cp $(PROJECT_NAME).sty ./texmf/tex/latex/$(PROJECT_NAME)/
	@cp $(PROJECT_NAME).dtx ./texmf/source/latex/$(PROJECT_NAME)/
	@cp $(PROJECT_NAME).ins ./texmf/source/latex/$(PROJECT_NAME)/
	@cp makefile ./texmf/source/latex/$(PROJECT_NAME)/
	@cp $(PROJECT_NAME).pdf ./texmf/doc/latex/$(PROJECT_NAME)/
	@cp README.ctan ./texmf/doc/latex/$(PROJECT_NAME)/README.md
	@cp LICENSE ./texmf/doc/latex/$(PROJECT_NAME)/
	@$(MAKE) distclean -C $(TESTDIR)
	@rsync -avq --exclude='$(TESTDIR)/extra' --exclude='$(TESTDIR)/media' --exclude='$(TESTDIR)/dev_*.tex' $(TESTDIR) ./texmf/doc/latex/$(PROJECT_NAME)
	@cd texmf/ ; zip -r9 ../$(PROJECT_NAME).tds.zip tex source doc
	
install: $(PROJECT_NAME).tds.zip
	@unzip -d ~/texmf ./$(PROJECT_NAME).tds.zip 

$(PROJECT_NAME).sty: $(PROJECT_NAME).dtx

$(PROJECT_NAME).pdf: $(PROJECT_NAME).dtx $(PROJECT_NAME).gls

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
