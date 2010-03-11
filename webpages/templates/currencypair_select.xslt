<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <select id="curr">
      <option selected=""> Select </option>
      <xsl:for-each select="ArrayOfcurrencypair/currencypair">
        <option>
          <xsl:attribute name="value">
            <xsl:value-of select="id"/>
          </xsl:attribute>
          <xsl:value-of select="base"/>/<xsl:value-of select="quote"/>
        </option>
      </xsl:for-each>
    </select>
  </xsl:template>
</xsl:stylesheet>
