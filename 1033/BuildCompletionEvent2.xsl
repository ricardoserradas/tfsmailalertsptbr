<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="TeamFoundation.xsl"/>
  <!-- Common TFS elements -->
  <xsl:template match="BuildCompletionEvent2">
    <head>
      <title _locID="Title">Team Foundation Server Build Completed</title>
      <!-- Pull in the common style settings -->
      <xsl:call-template name="style">
      </xsl:call-template>
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
    </head>
    <body>
      <table>
        <tr>
          <td class="PropName" _locID="TeamProject">Team Project: </td>
          <td class="PropValue">
            <xsl:value-of select="TeamProject"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="BuildNumber">Build Number: </td>
          <td class="PropValue">
            <xsl:value-of select="BuildNumber"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="BuildAgent">Build Controller: </td>
          <td class="PropValue">
            <xsl:value-of select="AgentPath"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="BuildDefinition">Build Definition: </td>
          <td class="PropValue">
            <xsl:value-of select="DefinitionPath"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="RequestedBy">Build started by: </td>
          <td class="PropValue">
            <xsl:value-of select="RequestedBy"/>

            <!-- Only display the requested for when it is present -->
            <xsl:if test="(count(RequestedFor) &gt; 0) and (RequestedFor != RequestedBy)">
                <!-- _locID_text="RequestedFor" -->(on behalf of: <xsl:value-of select="RequestedFor" />)
            </xsl:if>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="StartTime">Build Start Time: </td>
          <td class="PropValue">
            <xsl:value-of select="StartTime" />
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="FinishTime">Build Finish Time: </td>
          <td class="PropValue">
            <xsl:value-of select="FinishTime" />
          </td>
        </tr>
        <xsl:if test="StatusCode != 'Succeeded'">
          <tr>
            <td class="PropName" _locID="LogLocation">Build Log Location: </td>
            <td class="PropValue">
              <xsl:call-template name="link">
                <xsl:with-param name="format" select="'html'"/>
                <xsl:with-param name="embolden" select="'false'"/>
                <xsl:with-param name="link" select="LogLocation"/>
                <xsl:with-param name="displayText" select="LogLocation"/>
              </xsl:call-template>
            </td>
          </tr>
        </xsl:if>
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
