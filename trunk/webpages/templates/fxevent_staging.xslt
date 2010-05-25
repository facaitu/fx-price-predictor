<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <table cellpadding="0" cellspacing="0" border="0" class="display" id="fxeventlistTable">
      <thead>
      <tr>
        <th>Currency</th>
        <th>Event ID</th>
        <th>Name</th>
        <th>Next Date</th>
        <th>Recurring</th>
        <th>Previous</th>
        <th>Importance</th>
        <th>Watch</th>
        <th>Delete</th>
        <th>Alias Of</th>
      </tr>
      </thead>
      <tbody>
      <xsl:for-each select="ArrayOffxevent/fxevent_staging">
        <tr class="gradeA">
        <td>
          <xsl:value-of select="currency"/>
        </td>
        <td>
          <xsl:value-of select="eventid"/>
        </td>
        <td class="fxeventtable-name">
          <xsl:value-of select="name"/>
        </td>
        <td>
          <xsl:value-of select="substring(next_date,1,10)"/>
        </td>
        <td>
          <xsl:value-of select="recurring"/>
        </td>
        <td>
          <xsl:value-of select="previous"/>
        </td>
        <td>
          <xsl:value-of select="importance"/>
        </td>
        <td>
          <xsl:value-of select="watch"/>
        </td>
        <td>
          <xsl:element name="input">
            <xsl:attribute name="type">checkbox</xsl:attribute>
            <xsl:attribute name="value">
              <xsl:value-of select="eventid"/>
            </xsl:attribute>
            <xsl:attribute name="name">
              <xsl:text>delete</xsl:text>
              <xsl:value-of select="eventid"/>
            </xsl:attribute>
            <xsl:if test="@default='yes'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </xsl:element>
          </td>
          <td></td>
        </tr>
      </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
</xsl:stylesheet>
