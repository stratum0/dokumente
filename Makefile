#!/usr/bin/make -f
all: mediawiki pdf

mediawiki: Satzung.mediawiki Beitragsordnung.mediawiki

pdf: Satzung.pdf Beitragsordnung.pdf

%.mediawiki: %.markdown
	pandoc --template=templates/pandoc-template \
		--base-header-level=2 \
		-t mediawiki \
		-o $@ $<

%.pdf: %.markdown
	pandoc --template=templates/pandoc-template \
		-t latex \
		-o $@ $<
