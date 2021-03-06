# Copyright (C) 2012 Richard Mortier <mort@cantab.net>. All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 as published by
# the Free Software Foundation
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place - Suite 330, Boston, MA 02111-1307, USA.

.DEFAULT: test
.PHONY: site test clean deploy

LESSC = lessc
JEKYLL = jekyll
COFFEE = coffee
BIB2JSON = ~/src/python-scripts.git/bib2json.py
COFFEES = $(notdir $(wildcard _coffee/*.coffee))
JSS = $(patsubst %.coffee,js/%.js,$(COFFEES))
JSONS = papers/homework.json

json: $(JSONS)
papers/homework.json: papers/homework.bib
	$(BIB2JSON) papers/homework.bib >| papers/homework.json

js: $(JSS)
js/%.js: _coffee/%.coffee
	$(COFFEE) -c -o js $<

css: css/homework.css
css/homework.css: $(wildcard _less/*.less)
	mkdir -p css
	$(LESSC) --compress _less/homework.less >| css/homework.css

site: css js
	$(JEKYLL) build

test: css js
	$(JEKYLL) serve --watch

clean:
	$(RM) -r _site $(JSS) css/homework.css

deploy: site
	git status && git push
