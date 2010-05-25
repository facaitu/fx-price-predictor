<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="fxeventaliaslistTable">
      <thead>
      <tr>
        <th>Event ID</th>
        <th>Event Name</th>
        <th>Alias Name</th>
        <th>Delete</th>
      </tr>
      </thead>
      <tbody>
      <xsl:for-each select="ArrayOffxevent_alias/fxevent_alias">
      <tr class="gradeA">
        <td>
          <xsl:value-of select="eventid"/>
        </td>
        <td>
          <xsl:value-of select="event_name"/>
        </td>
        <td>
          <xsl:value-of select="alias_name"/>
        </td>
        <td>
          <xsl:element name="input">
            <xsl:attribute name="type">checkbox</xsl:attribute>
            <xsl:attribute name="value">
              <xsl:value-of select="id"/>
            </xsl:attribute>
            <xsl:attribute name="name">
              <xsl:text>delete</xsl:text>
              <xsl:value-of select="id"/>
            </xsl:attribute>
            <xsl:if test="@default='yes'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </xsl:element>
        </td>
      </tr>
      </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
