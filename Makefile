.DEFAULT_GOAL := recompile_latex

# Windows cmd clean commands
ifeq ($(OS),Windows_NT)
	SHELL := cmd.exe
	CLEAN_AUX = del /s *.aux
	CLEAN_IDX = del /s *.acn *.acr *.alg *.bbl *.blg *.glg *.glo *.gls *.glsdefs *.idx *.ilg *.ist *.listing *.lof *.log *.lol *.lot *.nlo *.nls *.out *.tdo *.toc

# Unix clean commands
else
	CLEAN_AUX +=-find . -name \*.aux -type f -delete
	CLEAN_IDX +=-rm -f *.acn *.acr *.alg *.bbl *.blg *.glg *.glo *.gls *.glsdefs \
	    *.idx *.ilg *.ist *.listing *.lof *.log *.lol *.lot *.nlo *.nls *.out *.tdo *.toc 2>/dev/null
endif


SOURCES      := $(shell find . -name '*.tex' -not -path './Verzeichnisse/*') # Document sources
INDICES      := $(shell find ./Verzeichnisse -name '*.tex')                  # Index files
BIBLIOGRAPHY := ./Verzeichnisse/Literaturverzeichnis.bib

NAME         := Arbeit

# Generate glossary entries file
$(NAME).glo: $(INDICES)
	pdflatex $(NAME)
	-makeglossaries $(NAME)

# Generate index file
$(NAME).nls: $(INDICES)
	-makeindex $(NAME).nlo -s nomencl.ist -o $(NAME).nls

# Generate bibliography index file
$(NAME).bbl: $(BIBLIOGRAPHY)
	pdflatex $(NAME)
	-bibtex $(NAME)

# Compile document & link images / create list of figures etc.
recompile_latex: $(SOURCES)
	pdflatex $(NAME)
	pdflatex $(NAME)

.PHONY: clean
clean:
	@$(CLEAN_AUX)
	@$(CLEAN_IDX)

all: $(NAME).glo $(NAME).nls $(NAME).bbl recompile_latex
full: all clean
