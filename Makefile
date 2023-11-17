.DEFAULT_GOAL := all

# Source files
SOURCES       := $(shell find . -name '*.tex' -not -path './Verzeichnisse/*') # Document sources
INDICES       := $(shell find ./Verzeichnisse -name '*.tex')                  # Index files
BIBLIOGRAPHY  := Verzeichnisse/Literaturverzeichnis.bib                       # Bibliography
GLOSSARY      := Verzeichnisse/Glossar.tex                                    # Glossary

NAME          := Arbeit
BUILD_DIR     := .build
ARGS_PDFLATEX := -output-directory=$(BUILD_DIR)

# Generate build directory (including child directories) if non-existant
$(BUILD_DIR):
	@for DIR in $(shell find . -maxdepth 1 -mindepth 1 -type d -not -name '.git' -exec basename '{}' \;); do \
		mkdir -p ${BUILD_DIR}/$$DIR; \
	done

# Generate glossary entries file
$(BUILD_DIR)/$(NAME).glo: $(BUILD_DIR) $(GLOSSARY)
	pdflatex $(ARGS_PDFLATEX) $(NAME)
	-makeglossaries $(NAME) -d $(BUILD_DIR)

# Generate index file
$(BUILD_DIR)/$(NAME).nls: $(BUILD_DIR) $(INDICES) $(SOURCES)
	-makeindex $(BUILD_DIR)/$(NAME).nlo -s nomencl.ist -o $(BUILD_DIR)/$(NAME).nls

# Generate bibliography index file
$(BUILD_DIR)/$(NAME).bbl: $(BUILD_DIR) $(BIBLIOGRAPHY)
	pdflatex $(ARGS_PDFLATEX) $(NAME)
	cp $(BIBLIOGRAPHY) $(BUILD_DIR)/$(BIBLIOGRAPHY)
	-cd $(BUILD_DIR) && bibtex $(NAME)

# Compile document & link images / create list of figures etc.
.PHONY: recompile_latex
recompile_latex: $(BUILD_DIR) $(SOURCES)
	pdflatex $(ARGS_PDFLATEX) $(NAME)
	pdflatex $(ARGS_PDFLATEX) $(NAME)
	@mv $(BUILD_DIR)/$(NAME).pdf .

.PHONY: clean
clean:
	rm -r $(BUILD_DIR)

.PHONY: all
all: $(BUILD_DIR)/$(NAME).glo $(BUILD_DIR)/$(NAME).nls $(BUILD_DIR)/$(NAME).bbl recompile_latex
full: all clean
