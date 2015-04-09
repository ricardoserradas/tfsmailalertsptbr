<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="TeamFoundation.xsl"/>
  <!-- Common TeamSystem elements -->
  <xsl:template match="TestRunCompletedEvent">
    <head>
      <title _locID="Title">Test Run Completed</title>
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
          <td class="PropName" _locID="Id">Id: </td>
          <td class="PropValue">
            <xsl:value-of select="Id"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="TestPlanId">Test Plan Id: </td>
          <td class="PropValue">
            <xsl:value-of select="TestPlanId"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="IsAutomated">Is Automated: </td>
          <td class="PropValue">
            <xsl:value-of select="IsAutomated"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="CreationDate">Creation Date: </td>
          <td class="PropValue">
            <xsl:value-of select="CreationDate"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="Owner">Owner: </td>
          <td class="PropValue">
            <xsl:value-of select="Owner"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="State">State: </td>
          <td class="PropValue">
            <xsl:value-of select="State"/>
          </td>
        </tr>
        <xsl:if test="BuildNumber != ''">
          <tr>
            <td class="PropName" _locID="BuildNumber">Build Number: </td>
            <td class="PropValue">
              <xsl:value-of select="BuildNumber" />
            </td>
          </tr>        
        </xsl:if>
        <xsl:if test="ErrorMessage != ''">
          <tr>
            <td class="PropName" _locID="ErrorMessage">Error Message: </td>
            <td class="PropValue">
              <xsl:value-of select="ErrorMessage" />
            </td>
          </tr>        
        </xsl:if>
        <xsl:if test="StartDate != ''">
          <tr>
            <td class="PropName" _locID="StartDate">Start Date: </td>
            <td class="PropValue">
              <xsl:value-of select="StartDate" />
            </td>
          </tr>        
        </xsl:if>        
        <xsl:if test="CompleteDate != ''">
          <tr>
            <td class="PropName" _locID="CompleteDate">Complete Date: </td>
            <td class="PropValue">
              <xsl:value-of select="CompleteDate" />
            </td>
          </tr>        
        </xsl:if>
        <xsl:if test="Comment != ''">
          <tr>
            <td class="PropName" _locID="Comment">Comment: </td>
            <td class="PropValue">
              <xsl:value-of select="Comment" />
            </td>
          </tr>        
        </xsl:if>
        <tr>
          <td class="PropName" _locID="TotalTests">Total Tests: </td>
          <td class="PropValue">
            <xsl:value-of select="TotalTests" />
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="PassedTests">Passed Tests: </td>
          <td class="PropValue">
            <xsl:value-of select="PassedTests" />
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="UnanalyzedTests">Unanalyzed Tests: </td>
          <td class="PropValue">
            <xsl:value-of select="UnanalyzedTests" />
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="LinkedWorkItemCount">Linked Work Item Count: </td>
          <td class="PropValue">
            <xsl:value-of select="LinkedWorkItemCount" />
          </td>
        </tr>                
        <tr>
          <td class="PropName" _locID="LastUpdated">Last Updated Date: </td>
          <td class="PropValue">
            <xsl:value-of select="LastUpdated" />
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="LastUpdatedBy">Last Updated By: </td>
          <td class="PropValue">
            <xsl:value-of select="LastUpdatedBy" />
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
