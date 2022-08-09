.DEFAULT_GOAL := recompile_latex

# Powershell clean commands
ifeq ($(OS),Windows_NT)
	CLEAN_AUX +=-Get-ChildItem * -Include *.aux -Recurse | Remove-Item
	CLEAN_IDX +=-Get-ChildItem * -Include *.acn,*.acr,*.alg,*.bbl,*.blg, \
	            *.glg,*.glo,*.gls,*.glsdefs,*.idx,*.ilg,*.ist,*.listing,*.lof,*.log, \
	            *.lol,*.lot,*.nlo,*.nls,*.out,*.tdo,*.toc -Recurse | Remove-Item

# Unix clean commands
else
	CLEAN_AUX +=-find . -name \*.aux -type f -delete
	CLEAN_IDX +=-rm -f *.acn *.acr *.alg *.bbl *.blg *.glg *.glo *.gls *.glsdefs \
	    *.idx *.ilg *.ist *.listing *.lof *.log *.lol *.lot *.nlo *.nls *.out *.tdo *.toc 2>/dev/null
endif

all:
	@pdflatex Arbeit && makeglossaries Arbeit && \
	 makeindex Arbeit.nlo -s nomencl.ist -o Arbeit.nls && \
	 pdflatex Arbeit && bibtex Arbeit && \
	 pdflatex Arbeit && pdflatex Arbeit
	@$(CLEAN_AUX)

recompile_latex:
	@pdflatex Arbeit && pdflatex Arbeit

.PHONY: clean
clean:
	@$(CLEAN_AUX)
	@$(CLEAN_IDX)

full: all clean