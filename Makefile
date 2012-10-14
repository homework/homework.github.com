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

css: css/homework.css
css/homework.css: $(wildcard _less/*.less)
	mkdir -p css
	$(LESSC) --compress _less/homework.less >| css/homework.css

site: css
	$(JEKYLL)

test: css
	$(JEKYLL) --auto --serve --safe

clean:
	$(RM) -r _site css

deploy: site
	git status && git push
