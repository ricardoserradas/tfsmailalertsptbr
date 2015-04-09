<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="TeamFoundation.xsl"/>
  <!-- Common TFS elements -->
  <xsl:template match="BuildStatusChangeEvent">
    <head>
      <title _locID="Title">Team Foundation Server - Mudança na Qualidade de Build</title>
      <!-- Pull in the common style settings -->
      <xsl:call-template name="style">
      </xsl:call-template>
    </head>
    <div class="Title">
      <xsl:call-template name="link">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="embolden" select="'true'"/>
        <xsl:with-param name="fontSize" select="'larger'"/>
        <xsl:with-param name="link" select="Url"/>
        <xsl:with-param name="displayText" select="Title"/>
      </xsl:call-template>
    </div>
    <br/>
    <body>
      <table>
        <tr>
          <td class="PropName" _locID="TeamProject">Team project:</td>
          <td class="PropValue">
            <xsl:value-of select="TeamProject" />
          </td>
        </tr>

        <tr>
          <td class="PropName" _locID="BuildNumber">Id do Build:</td>
          <td class="PropValue">
            <xsl:value-of select="Id" />
          </td>
        </tr>

        <tr>
          <td class="PropName" _locID="Details">Detalhes:</td>
          <td class="PropValue" _locID="DetailsMessage">
            Qualidade do Build modificada de <xsl:value-of select="ChangedBy"/> de &apos;<xsl:value-of select="StatusChange/OldValue"/>&apos; para &apos;<xsl:value-of select="StatusChange/NewValue"/>&apos;
          </td>
        </tr>

        <tr>
          <td class="PropName" _locID="ChangedBy">Modificado por:</td>
          <td class="PropValue">
            <xsl:value-of select="ChangedBy" />
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="ChangedOn">Modificado em:</td>
          <td class="PropValue">
            <xsl:value-of select="ChangedTime" />
          </td>
        </tr>
      </table>
      <br/>
      <xsl:call-template name="footer">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="alertOwner" select="Subscriber"/>
        <xsl:with-param name="timeZoneOffset" select="TimeZoneOffset"/>
        <xsl:with-param name="timeZoneName" select="TimeZone"/>
      </xsl:call-template>
    </body>
  </xsl:template>
</xsl:stylesheet>
