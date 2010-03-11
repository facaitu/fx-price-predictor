<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="@* | node()">
      <tr class="gradeA">
        <td class="currencypair-addnewtd">
          <input id="base" name="base" type="text" value="" size="3" maxlength="3" />/<input id="quote" name="quote" type="text" value="" size="3" maxlength="3" />
        </td>
        <td></td>
      </tr>
    </xsl:template>
</xsl:stylesheet>
