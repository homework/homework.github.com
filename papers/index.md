---
layout: page
description: the homework project &rdquo; papers
js: [papers]
---

Publications
============

Homework was  an inter-disciplinary research project, and so produced outputs in a wide range of venues. Good summaries of the project are to be found in [UIST 2012](#uist12) and [IM 2011](#im11), and the complete BibTeX citation database is [here](./homework.bib).


<div id="entries">
Loading...
</div>

<script type="text/javascript">
  $(document).ready(function () {
    papers
      .fetch("./authors.json", "./homework.json")
      .render("#entries")
  });
</script>

