<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- When there's STEM inside a listing, the DocBook <inlineequation> has the
       expression duplicated inside both <alt> and <mathphrase> elements.
       Let's drop the <alt> so we just get the expression once. -->

  <xsl:template match="inlineequation" mode="latex.programlisting">
    <xsl:param name="co-tagin" select="'&lt;'"/>
    <xsl:param name="rnode" select="/"/>
    <xsl:param name="probe" select="0"/>

    <!-- Ignore this layer, but process children. -->
    <xsl:apply-templates mode="latex.programlisting">
      <xsl:with-param name="co-tagin" select="$co-tagin"/>
      <xsl:with-param name="rnode" select="$rnode"/>
      <xsl:with-param name="probe" select="$probe"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="inlineequation/alt" mode="latex.programlisting">
    <xsl:param name="co-tagin" select="'&lt;:'"/>
    <xsl:param name="rnode" select="/"/>
    <xsl:param name="probe" select="0"/>

    <xsl:text><!-- ignore it --></xsl:text>
  </xsl:template>

  <xsl:template match="inlineequation/mathphrase" mode="latex.programlisting">
    <xsl:param name="co-tagin" select="'&lt;:'"/>
    <xsl:param name="rnode" select="/"/>
    <xsl:param name="probe" select="0"/>

    <!-- We cannot call verbatim.embed or the other builtins because those
         throw additional <t> around the math, that never gets removed. -->

    <!-- TODO this probably needs \ensuremath or something. -->
    <xsl:if test="$probe = 0">
      <xsl:value-of select="."/>
    </xsl:if>
  </xsl:template>


  <xsl:template match="subscript" mode="latex.programlisting">
    <xsl:param name="co-tagin" select="'&lt;:'"/>
    <xsl:param name="rnode" select="/"/>
    <xsl:param name="probe" select="0"/>

    <xsl:call-template name="verbatim.embed">
      <xsl:with-param name="co-tagin" select="$co-tagin"/>
      <xsl:with-param name="rnode" select="$rnode"/>
      <xsl:with-param name="probe" select="$probe"/>
      <xsl:with-param name="content">
        <xsl:choose>
          <xsl:when test="1 = 0">
            <!-- This feels like the "right" approach, and the TeX more closely
                 matches that outside of listings. But, unlike there this resets
                 any surrounding italics, so things are inconsistent.  I think
                 the problem is that listings turns <emphasis> into \itshape
                 but otherwise <emphasis> becomes \emph -->
            <xsl:call-template name="inline.subscriptseq">
              <xsl:with-param name="content">
                <xsl:apply-templates mode="latex.programlisting"/>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- This doesn't pub the subscript back into text mode, which might
                 cause problems, but at least it stays italicised. -->
            <xsl:text>$_{</xsl:text>
            <xsl:apply-templates mode="latex.programlisting"/>
            <xsl:text>}$</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
