<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <select id="curr">
      <option selected=""> Select </option>
      <xsl:for-each select="ArrayOfcurrency/currency">
        <option>
          <xsl:attribute name="value">
            <xsl:value-of select="currencyid"/>
          </xsl:attribute>
          <xsl:value-of select="currencyid"/>
        </option>
      </xsl:for-each>
    </select>
  </xsl:template>
</xsl:stylesheet>
