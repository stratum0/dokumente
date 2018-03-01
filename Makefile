#!/usr/bin/make -f
SRCS=$(wildcard \
     Mitgliederversammlung*.tex \
     Gründungsversammlung*.tex \
     Satzung.tex \
     Beitragsordnung.tex \
     Spaceordnung.tex \
)
JOBNAMES=$(basename $(SRCS))
PDFS=$(addsuffix .pdf,$(JOBNAMES))
LATESTJOB=$(basename $(shell ls -1t $(SRCS) | head -n 1))

define latexmk
latexmk -pdf -dvi- -ps-
endef

all: $(PDFS)

help:
	@echo "Available make targets:"
	@echo "  make, make all  -- build PDFs for all .tex documents"
	@echo "  make clean      -- remove all temporary files"
	@echo "  make mrproper   -- remove all temporary and output files"
	@echo "  make help       -- this help"
	@echo "  make doc.pdf    -- build doc.pdf from doc.tex"
	@echo "  make preview    -- build the most recent .tex file, and set PVC=1"
	@echo
	@echo "Variables:"
	@echo "  PVC=1           -- when building, start a PDF viewer and poll for updates"
	@echo "                     on the .tex file"

clean:
	rm -f	$(addsuffix .aux,$(JOBNAMES)) \
		$(addsuffix .fdb_latexmk,$(JOBNAMES)) \
		$(addsuffix .fls,$(JOBNAMES)) \
		$(addsuffix .log,$(JOBNAMES)) \
		$(addsuffix .out,$(JOBNAMES)) \
		$(addsuffix .toc,$(JOBNAMES)) \
		vc.tex

mrproper: clean
	rm -f $(PDFS)

preview:
	$(latexmk) -pvc $(LATESTJOB).tex

vc.tex: .git/index .git/HEAD scripts/vc scripts/vc-git.awk
	cd scripts; sh ./vc -m && mv vc.tex ..

%.pdf: %.tex vc.tex
	$(latexmk) $(if $(PVC),-pvc,-pvc-) "$<"

# vim: ft=make ts=8 noet
