<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="@* | node()">
      <tr class="gradeA" id="newEventRow">
        <td>
          <input id="curr" name="curr" type="text" value="USD" size="3" maxlength="3" />
        </td>
        <td>
          <input id="eventid" name="eventid" type="text" value="" size="10" maxlength="10" />
        </td>
        <td>
          <input id="name" name="name" type="text" value="" size="30" maxlength="50" />
        </td>
        <td>
          <input id="next_date" name="next_date" class="datepicker" type="text" size="10" maxlength="10" value="" />
        </td>
        <td>
          <select id="recurring">
            <option value="1" selected="">Yes</option>
            <option value="0">No</option>
          </select>
        </td>
        <td>
          <input id="previous" name="previous" size="7" maxlength="10" type="text" value="" />
        </td>
        <td>
          <select id="importance">
            <option value="1">1 (Low)</option>
            <option value="2" selected="">2 (Med)</option>
            <option value="3">3 (High)</option>
          </select>
        </td>
        <td>
          <select id="watch">
            <option value="1" selected="">Yes</option>
            <option value="0">No</option>
          </select>
        </td>
        <td></td>
      </tr>
    </xsl:template>
</xsl:stylesheet>
