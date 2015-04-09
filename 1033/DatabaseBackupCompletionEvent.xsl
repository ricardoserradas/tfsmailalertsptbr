<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="TeamFoundation.xsl"/>
  <xsl:template match="DatabaseBackupCompletionEvent">
    <head>
      <!-- Pull in the command style settings -->
      <xsl:call-template name="style">
      </xsl:call-template>
    </head>
    <body>
      <div class="Title">
        <b>
          <xsl:value-of select="Title"/>
        </b>
      </div>
      <br/>
      <table class="WithBorder">
        <tr>
          <td class="PropName">
            <!-- _locID_text="StartTime" -->Start Time:
          </td>
          <td class="PropValue">
            <xsl:value-of select="StartTime"/>
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="EndTime" -->End Time:
          </td>
          <td class="PropValue">
            <xsl:value-of select="EndTime"/>
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="ApplicationTier" -->Application Tier:
          </td>
          <td class="PropValue">
            <xsl:value-of select="ApplicationTier"/>
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="LogFile" -->Log File:
          </td>
          <td class="PropValue">
            <xsl:value-of select="LogFile"/>
          </td>
        </tr>
      </table>
      <br/>
      <div>
        <xsl:value-of select="Message"/>
      </div>
    </body>
  </xsl:template>
</xsl:stylesheet>
