<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <select id="event_alias_name">
      <option selected=""> Select </option>
      <xsl:for-each select="ArrayOfcurrency/fxevent_alias">
        <option>
          <xsl:attribute name="value">
            <xsl:value-of select="eventid"/>
          </xsl:attribute>
          <xsl:text>(</xsl:text>
          <xsl:value-of select="eventid"/>
          <xsl:text>) </xsl:text>
          <xsl:value-of select="event_name"/>
        </option>
      </xsl:for-each>
    </select>
  </xsl:template>
</xsl:stylesheet>
