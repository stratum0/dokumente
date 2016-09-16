#!/usr/bin/make -f
all: mediawiki pdf

mediawiki: Satzung.mediawiki Beitragsordnung.mediawiki

pdf: Satzung.pdf Beitragsordnung.pdf

%.mediawiki: %.markdown templates/pandoc-template.mediawiki
	pandoc --template=templates/pandoc-template \
		--base-header-level=2 \
		-t mediawiki \
		-o $@ $<

%.pdf: %.markdown templates/pandoc-template.latex
	pandoc --template=templates/pandoc-template \
		-t latex \
		-o $@ $<
