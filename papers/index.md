---
layout: page
description: the homework project &rdquo; papers
js: [papers]
---

+--

Publications
============

=--

Homework was  an inter-disciplinary research project, and so produced outputs in a wide range of venues. 

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

