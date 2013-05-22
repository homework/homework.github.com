###
# 
# Copyright (C) 2013 Richard Mortier <mort@cantab.net>.
# All Rights Reserved.
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
# 
###

self = exports ? this

_promises = []
_authors = null
_papers = null

## rendering helpers
wrap = (tag, s, {cl, id, colspan, literal}) ->
  cl = if cl? then "class='#{cl}'" else ""
  id = if id? then "id='#{id}'" else ""
  colspan = if colspan? then "colspan='#{colspan}'" else ""
  literal = if literal? then literal else ""
  "<#{tag} #{id} #{cl} #{colspan} #{literal}>#{s}</#{tag}>"

div = (o, s) -> wrap "div", s, o
span = (o, s) -> wrap "span", s, o
ul = (o, lis) -> wrap "ul", lis, o
li = (o, s) -> wrap "li", s, o
p = (o, s) -> wrap "p", s, o
small = (o, s) -> wrap "small", s, o
footer = (o, s) -> wrap "footer", s, o
button = (o, s) -> wrap "button", s, o
em = (o, s) -> wrap "em", s, o

table = (o, s) -> wrap "table", s, o
tbody = (o, s) -> wrap "tbody", s, o
thead = (o, s) -> wrap "thead", s, o
th = (o, s) -> wrap "th", s, o
tr = (o, s) -> wrap "tr", s, o
td = (o, s) -> wrap "td", s, o

hd = (n, o, s) -> wrap "h#{n}", s, o

link = (o, u, s) ->
  o.literal =
    if o.literal? then """href="#{u}" #{o.literal}""" else """href="#{u}" """
  wrap "a", s, o

month = (m) ->
  switch m
    when "jan" then "January"
    when "feb" then "February"
    when "mar" then "March"
    when "apr" then "April"
    when "may" then "May"
    when "jun" then "June"
    when "jul" then "July"
    when "aug" then "August"
    when "sep" then "September"
    when "oct" then "October"
    when "nov" then "November"
    when "dec" then "December"
    else ""

code = (e) ->
  y = e.year
  m = switch e.month
    when "jan", "January" then "01"
    when "feb", "February" then "02"
    when "mar", "March" then "03"
    when "apr", "April" then "04"
    when "may", "May" then "05"
    when "jun", "June" then "06"
    when "jul", "July" then "07"
    when "aug", "August" then "08"
    when "sep", "September" then "09"
    when "oct", "October" then "10"
    when "nov", "November" then "11"
    when "dec", "December" then "12"
    else "00"

  "#{y}-#{m}"

entry = (e) ->
  authors = e.author.map (a) -> 
    name = a
      .replace(/\b(\w)\w+ /, "$1. ")
      .replace(/(\w\.) (\w\.)/, "$1$2")
      .replace(/(\w\.) (\w\.)/, "$1$2")
            
    if (a of _authors) then name = link {}, _authors[a], name
    span {cl:"author"}, name

  venue = switch e._type
    when "inproceedings" then e.booktitle
    when "article" then "#{e.journal}, #{e.volume} (#{e.number}):#{e.pages}"
    when "inbook" then "#{e.title} #{e.chapter}, #{e.publisher}"
    when "techreport" then "#{e.number}, #{e.institution}"
    when "patent" then e.number
    else ""

  address = if "address" in e then span {cl:"address"}, "#{e.address}." else ""
  links = if ("pdf" of e) then link {cl:"url pdf"}, e.pdf, "pdf " else ""
                                                                                  
  div {cl:"paper", id:"#{e._key}"},
    ((link {}, "##{e._key}", " ") +
     (span {cl:"linkbar"}, links) +
     (span {cl:"title"}, e.title)+'<br>' +
     authors.join(", ")+'<br>'+
     "#{span {cl:"venue"}, venue}. " +
     (if e.note then "#{e.note}. " else '') +
     "#{month e.month} #{e.year}. #{address}"
    )
    
papers =
  fetch: (au, pu) ->
    _promises.push $.Deferred (promise) -> 
      $.getJSON au, (data) ->
        _authors = data
        promise.resolve()

    _promises.push $.Deferred (promise) -> 
      $.getJSON pu, (data) ->
        _papers = data
        promise.resolve()

    @

  render: (tgt) ->
    $.when.apply(null, _promises).then =>
      $(tgt).html('')

      entries = {}
      yms = []
      
      $.each _papers.records, (k, e) ->
        e._key = k
        k = code e
        if not entries[k]? then entries[k] = []
        entries[k].push e
      
      yms = (ym for ym of entries).sort().reverse()

      oy = null
      last = false
      $.each yms, (i, ym) ->
        y = ym.split("-")[0]
        if oy == null || y != oy
          if oy != null then $(tgt).append (div {cl:"break"}, '')
          $(tgt).append div {cl:"year", id:"y-#{y}"}, y
          oy = y

        $.each entries[ym], (i, e) ->
          console.log "#{i}, #{JSON.stringify e}"
          $(tgt).append entry e

      tool = link {}, _papers.tool.url, _papers.tool.name
      $(tgt).after div {cl:"well well-small text-right tool"}, 
        "Generated by #{tool} on #{_papers.date}."

    @
                                    
self.papers = papers
