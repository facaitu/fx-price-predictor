<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="@* | node()">
    <tr class="gradeA">
      <td>
        <input id="eventid" name="eventid" type="text" value="" size="10" maxlength="10" />
      </td>
      <td>
        <input id="name" name="aliasname" type="text" value="" size="30" maxlength="50" />
      </td>
      <td></td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
