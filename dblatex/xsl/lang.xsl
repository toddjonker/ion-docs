<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template name="encode.before.style">
    <xsl:param name="lang"/>

    <xsl:if test="$latex.encoding != 'utf8'">
      <xsl:message terminate="yes">
        <xsl:text>Error: $latex.encoding must be 'utf8'</xsl:text>
      </xsl:message>
    </xsl:if>

    <!-- We omit T2A to avoid installing texlive-lang-cyrillic.
         I don't know what T2D does, but it doesn't seem to hurt. -->
    <xsl:text>\usepackage[T2D,T1]{fontenc}&#10;</xsl:text>
    <xsl:text>\usepackage[utf8]{inputenc}&#10;</xsl:text>
    <xsl:text>\usepackage{pmboxdraw}&#10;</xsl:text>
    <xsl:text>\def\hyperparamadd{unicode=true}&#10;</xsl:text>
  </xsl:template>


  <xsl:template name="encode.after.style">
    <xsl:param name="lang"/>

    <xsl:text>\lstset{inputencoding=utf8, extendedchars=true}&#10;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
