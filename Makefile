# ------------------------------------------------------------------------------
# Variables

tex_files = document.tex document.bib background.tex conclusion.tex design.tex \
		development.tex introduction.tex validation.tex

aux_files = document.aux document.bbl document.bcf document.blg document.idx \
		document.log document.run.xml document.synctex.gz document.toc \
		pdfa.xmpi

aux_folders = ./_minted/

output_file = document.pdf

compile_tex = lualatex --jobname=document -file-line-error -shell-escape \
		--synctex=1 -interaction=nonstopmode

.DEFAULT_GOAL := all
.PHONY: clean cleanall

# ------------------------------------------------------------------------------
# Rules

all: $(output_file)

document.pdf: $(tex_files)
	@echo "Compiling 1/4: lualatex"
	@$(compile_tex) document.tex > /dev/null
	@echo "Compiling 2/4: biber"
	@biber document > /dev/null
	@echo "Compiling 3/4: lualatex"
	@$(compile_tex) document.tex > /dev/null
	@echo "Compiling 4/4: lualatex"
	@$(compile_tex) document.tex > /dev/null
	@echo "Done"

clean:
	rm -f $(aux_files)
	rm -rf $(aux_folders)

cleanall: clean
	rm -f $(output_file)
