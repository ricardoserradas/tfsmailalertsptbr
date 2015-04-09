<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="TeamFoundation.xsl"/>

  <!-- Common strings -->
  <xsl:variable name="name"><!-- _locID_text="name"-->Name</xsl:variable>
  <xsl:variable name="referenceName"><!-- _locID_text="referenceName"-->Reference Name</xsl:variable>
  
  <xsl:template match="WITAdapterSchemaConflictEvent">
    <head>
      <title>
        <xsl:value-of select="Title"/>
      </title>
      <!-- Pull in the command style settings -->
      <xsl:call-template name="style">
      </xsl:call-template>
      <div class="Title">
        <b>
          <xsl:value-of select="Title" />
        </b>
      </div>
    </head>
    <body lang="EN-US" link="blue" vlink="purple">
      <br />
      <div>
        <pre>
          <xsl:value-of select="Message" />
        </pre>
      </div>
      <br/>
      <b _locID="summary">Summary</b>
      <table style="table-layout: fixed">
        <tr>
          <td _locID="targetCollection" class="PropName">Target Collection:</td>
          <td class="PropValue">
            <xsl:value-of select="TeamProjectCollectionName"/>
          </td>
        </tr>
        <tr>
          <td _locID="notificationTime" class="PropName">Notification Time:</td>
          <td class="PropValue">
            <xsl:value-of select="EventTime"/>
          </td>
        </tr>
        <tr>
          <td _locID="blockedFields" class="PropName">Blocked Fields:</td>
          <td class="PropValue">
            <xsl:value-of select="count(Conflicts/Conflict)" />
          </td>
        </tr>
      </table>     
      <!-- Add the versioned items -->
      <xsl:if test="count(Conflicts) > 0">
        <br/>
        <b _locID="conflicts">Conflicts</b>
        <table class="WithBorder">
          <tr>
            <td class="ColHeading" colspan="2" align="center" _locID="blockedField"><b>Blocked Field</b></td>
            <td class="ColHeading" colspan="3" align="center" _locID="conflictingField"><b>Conflicting Field</b></td>
          </tr>
          <tr>
            <td class="ColHeading"><b><xsl:value-of select="$name"/></b></td>
            <td class="ColHeading"><b><xsl:value-of select="$referenceName"/></b></td>
            <td class="ColHeading"><b><xsl:value-of select="$name"/></b></td>
            <td class="ColHeading"><b><xsl:value-of select="$referenceName"/></b></td>
            <td class="ColHeading" _locID="collectionName"><b>Collection</b></td>
          </tr>
          <xsl:for-each select="Conflicts/Conflict">
            <xsl:call-template name="ConflictingFields">
              <xsl:with-param name="blockedField" select="BlockedField" />
              <xsl:with-param name="conflictingFields" select="ConflictingFields" />
            </xsl:call-template>
          </xsl:for-each>
        </table>
      </xsl:if>
      <xsl:call-template name="footer">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="alertOwner" select="Subscriber"/>
        <xsl:with-param name="timeZoneOffset" select="TimeZoneOffset"/>
        <xsl:with-param name="timeZoneName" select="TimeZone"/>
      </xsl:call-template>
    </body>
  </xsl:template>
  <xsl:template name="ConflictingFields">
    <xsl:param name="blockedField" />
    <xsl:param name="conflictingFields" />
    <xsl:for-each select="$conflictingFields/WITField">
      <tr>
        <td class="ColData">
          <xsl:value-of select="$blockedField/ReportingDisplayName" />
        </td>
        <td class="ColData">
          <xsl:value-of select="$blockedField/ReportingReferenceName" />
        </td>
        <td class="ColData">
          <xsl:value-of select="ReportingDisplayName"/>
        </td>
        <td class="ColData">
          <xsl:value-of select="ReportingReferenceName"/>
        </td>
        <td class="ColData">
          <xsl:value-of select="TeamProjectCollectionName"/>
        </td>
      </tr>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
