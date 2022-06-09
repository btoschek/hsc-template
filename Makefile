.DEFAULT_GOAL := recompile_latex

full:
	@pdflatex Arbeit && makeglossaries Arbeit && \
	 makeindex Arbeit.nlo -s nomencl.ist -o Arbeit.nls && \
	 pdflatex Arbeit && pdflatex Arbeit && bibtex Arbeit && \
	 pdflatex Arbeit && pdflatex Arbeit
	@-find . -name \*.aux -type f -delete

recompile_latex:
	@pdflatex Arbeit && pdflatex Arbeit

.PHONY: clean
clean:
	@-find . -name \*.aux -type f -delete
	@-rm *.acn *.acr *.alg *.bbl *.blg *.glg *.glo *.gls *.glsdefs \
	     *.idx *.ilg *.ist *.lof *.log *.lol *.lot *.nlo *.nls *.out *.tdo *.toc