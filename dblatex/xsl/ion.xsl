<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- The dblatex XSL parameters are documented here:
       https://dblatex.sourceforge.net/doc/manual/sec-params.html -->

  <!-- Don't show collaborators/authors table. (Set by xmlto) -->
  <xsl:param name="doc.collab.show">0</xsl:param>

  <!-- We want the TOC links in the titles, and in blue.
    Documentation:
     http://mirrors.ctan.org/macros/latex/contrib/hyperref/doc/hyperref-doc.html
  -->
  <xsl:param name="latex.hyperparam">colorlinks, linkcolor=blue, linktoc=all, urlcolor=blue</xsl:param>

  <!-- Don't show revision history. (Set by xmlto.) -->
  <xsl:param name="latex.output.revhistory">0</xsl:param>

  <!-- Potentially, scale the font size in verbatim blocks to fit their width.
       https://dblatex.sourceforge.net/doc/manual/sec-verbatim.html -->
  <xsl:param name="literal.extensions">0</xsl:param>


  <!-- These are partitioned to reflect the dblatex files they override. -->
  <xsl:include href="equation.xsl"/>
  <xsl:include href="lang.xsl"/>
  <xsl:include href="verbatim.xsl"/>

</xsl:stylesheet>
