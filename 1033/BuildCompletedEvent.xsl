<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:tb="http://schemas.microsoft.com/TeamFoundation/2010/Build" xmlns:ms="urn:schemas-microsoft-com:xslt">
  <!-- Common TeamSystem elements -->
  <xsl:import href="TeamFoundation.xsl"/>
  <xsl:output method = "html" doctype-public ="-//W3C//DTD HTML 4.01//EN"/>
  <xsl:output encoding="utf-8" indent="yes" method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <style type="text/css">
          body {
          font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
          font-size: 10pt;
          margin: 0 0.5em;
          }
        </style>
        <title>
          <!-- _locID_text="MainTitle" -->Build <xsl:value-of select="/tb:BuildCompletedEvent/tb:Build/@BuildNumber"/>
        </title>
      </head>
      <body>
        <xsl:apply-templates select="*"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="tb:BuildCompletedEvent">
    <!-- FullPath is of format \teamProjectName\buildDefName.  Extract the pieces -->
    <xsl:variable name="buildDefName" select ="substring-after(substring-after(tb:Definition/@FullPath, '\'), '\')"/>
    <xsl:variable name="teamProjectName" select ="substring-before(substring-after(tb:Definition/@FullPath, '\'), '\')"/>
    <p style="margin-bottom: .5em; padding: .5em 1em; background-color: #ffc; border: solid 1px #999999;">
      <strong>
        <xsl:value-of select="tb:Build/@BuildNumber"/>
      </strong> -
      <xsl:choose>
        <xsl:when test="tb:Build/@Reason = 'CheckInShelveset'">
          <xsl:variable name="totalRequests" select="count(tb:Requests/tb:QueuedBuild)" />
          <xsl:variable name="succeededRequests" select="count(tb:Build/tb:Information/tb:BuildInformationNode[@Type = 'CheckInOutcome'][count(tb:Fields/tb:InformationField[@Name = 'RequestId' and @Value > 0]) > 0][count(tb:Fields/tb:InformationField[@Name = 'ChangesetId' and @Value > 0]) > 0])" />
          <xsl:choose>
            <xsl:when test="$totalRequests = 1">
              <xsl:choose>
                <xsl:when test="$succeededRequests = 0">
                  <!-- _locID_text="CheckInRejected" -->Check-in Rejected
                </xsl:when>
                <xsl:otherwise>
                  <!-- _locID_text="CheckInCommitted" -->Check-in Committed
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <!-- _locID_text="Committed_N_Requests"-->Committed <xsl:value-of select="$succeededRequests"/> Changesets for <xsl:value-of select="$totalRequests" /> Check-in Requests
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="tb:Build/@Status = 'Succeeded'">
              <!-- _locID_text="Succeeded" -->Succeeded
            </xsl:when>
            <xsl:when test="tb:Build/@Status = 'PartiallySucceeded'">
              <!-- _locID_text="PartiallySucceeded" -->Partially Succeeded
            </xsl:when>
            <xsl:when test="tb:Build/@Status = 'Failed'">
              <!-- _locID_text="Failed" -->Failed
            </xsl:when>
            <xsl:otherwise>
              <!-- _locID_text="Stopped" -->Stopped
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
      <div>
        <span>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="tb:Uri" />
            </xsl:attribute>
            <!-- _locID_text="OpenInVS" -->Open Build Report in Visual Studio
          </a>
          |
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="tb:WebAccessUri" />
            </xsl:attribute>
            <!-- _locID_text="OpenInTswa" -->Open Build Report in Web Access
          </a>
        </span>
      </div>
    </p>
    <p>
      <xsl:choose>
        <xsl:when test="tb:Build/@Reason = 'IndividualCI'">Continuous Integration</xsl:when>
        <xsl:when test="tb:Build/@Reason = 'BatchedCI'">Rolling</xsl:when>
        <xsl:when test="tb:Build/@Reason = 'Schedule' or tb:Build/@Reason = 'ScheduleForced'">Scheduled</xsl:when>
        <xsl:when test="tb:Build/@Reason = 'ValidateShelveset'">Private</xsl:when>
        <xsl:when test="tb:Build/@Reason = 'CheckInShelveset'">Gated Check-in</xsl:when>
        <xsl:otherwise>Manual</xsl:otherwise>
      </xsl:choose>
      Build of <xsl:value-of select="$buildDefName"/> (<xsl:value-of select="$teamProjectName"/>)<br/>
      Ran for 
      <xsl:call-template name ="durationToMinutes">
        <xsl:with-param name="seconds" select="tb:Duration"/>
      </xsl:call-template> minutes 
      (<xsl:value-of select="tb:Controller/@Name"/>), 
      completed at <xsl:call-template name="formatDateTime"><xsl:with-param name="dateTime" select="tb:FinishTimeLocal"/></xsl:call-template>
    </p>
    <h2 style="font-size: 12pt; margin-bottom: 0em;">
      <span _locID="RequestSummary">Request Summary</span>
    </h2>
    <div style="margin-left:1em">
      <table style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 10pt;">
        <xsl:apply-templates select="tb:Requests/tb:QueuedBuild">
          <xsl:sort select="@Id"/>
        </xsl:apply-templates>
      </table>
    </div>
    <h2 style="font-size: 12pt; margin-bottom: 0em;">
      <span _locID="BuildSummary">Summary</span>
    </h2>
    <div style="margin-left:1em;font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 10pt;">
      <xsl:apply-templates select="tb:Build/tb:Information/tb:BuildInformationNode[@Type = 'ConfigurationSummary']">
        <xsl:sort select="tb:Fields/tb:InformationField[@Name = 'Platform']/@Value"/>
      </xsl:apply-templates>
      <xsl:variable name="otherErrors" select="count(tb:Build/tb:Information/tb:BuildInformationNode[@Type = 'BuildError' and (count(@ParentId) = 0 or @ParentId = 0)])"/>
      <xsl:if test="$otherErrors > 0">
        Other Errors
        <table style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 10pt; padding-left: 2em;">
          <tr>
            <td>
              <span _locID="OtherErrors">
                <xsl:value-of select="$otherErrors"/> error(s)
              </span>
            </td>
          </tr>
          <xsl:apply-templates select="tb:Build/tb:Information/tb:BuildInformationNode[@Type = 'BuildError' and (count(@ParentId) = 0 or @ParentId = 0)]"/>
        </table>
      </xsl:if>
    </div>
    <xsl:if test="count(tb:Build/tb:Information/tb:BuildInformationNode[@Type = 'AssociatedChangeset']) > 0">
      <h2 style="font-size: 12pt; margin-bottom: 0em;">
        <span _locID="AssociatedChangesets">Associated Changesets</span>
      </h2>
      <div style="margin-left:1em">
        <table style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 10pt;">
          <xsl:apply-templates select="tb:Build/tb:Information/tb:BuildInformationNode[@Type = 'AssociatedChangeset']">
            <xsl:sort select="tb:Fields/tb:InformationField[@Name = 'ChangesetId']/@Value"/>
          </xsl:apply-templates>
        </table>
      </div>
    </xsl:if>
    <xsl:if test="count(tb:Build/tb:Information/tb:BuildInformationNode[@Type = 'AssociatedWorkItem']) > 0">
      <h2 style="font-size: 12pt; margin-bottom: 0em;">
        <span _locID="AssociatedWorkItems">Associated Work Items</span>
      </h2>
      <div style="margin-left:1em">
        <table style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 10pt;">
          <xsl:apply-templates select="tb:Build/tb:Information/tb:BuildInformationNode[@Type = 'AssociatedWorkItem']">
            <xsl:sort select="tb:Fields/tb:InformationField[@Name = 'WorkItemId']/@Value"/>
          </xsl:apply-templates>
        </table>
      </div>
    </xsl:if>
    <!-- Apply the standard TFS footer -->
    <xsl:call-template name="footer">
      <xsl:with-param name="format" select="'html'"/>
      <xsl:with-param name="alertOwner" select="tb:Subscriber"/>
      <xsl:with-param name="timeZoneOffset" select="tb:TimeZoneOffset"/>
      <xsl:with-param name="timeZoneName" select="tb:TimeZone"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="tb:BuildInformationNode[@Type = 'AssociatedChangeset']">
    <tr>
      <td style="padding-right:2em">
        <strong>
          <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'CheckedInBy']/@Value"/>.
        </strong>
        <xsl:call-template name="linefeed2br">
          <xsl:with-param name="StringToTransform" select="tb:Fields/tb:InformationField[@Name = 'Comment']/@Value"/>
        </xsl:call-template>
        - 
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'WebAccessUri']/@Value"/>
          </xsl:attribute>
          Changeset <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'ChangesetId']/@Value"/>
        </a>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="tb:BuildInformationNode[@Type = 'AssociatedWorkItem']">
    <tr>
      <td style="padding-right: 2em">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'WebAccessUri']/@Value"/>
          </xsl:attribute>
          <!-- _locID_text="WorkItem" -->Work Item <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'WorkItemId']/@Value"/>
        </a>
      </td>
      <td style="padding-right: 2em;">
        <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'Title']/@Value"/>
      </td>
    </tr>
    <tr>
      <td colspan="2" style="padding-right: 2em; color: #888;">
        <span _locID="WorkItemState">
          Current state is <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'Status']/@Value"/>.
          <xsl:choose>
            <xsl:when test="tb:Fields/tb:InformationField[@Name = 'AssignedTo']/@Value != ''">
              Currently assigned to <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'AssignedTo']/@Value"/>.
            </xsl:when>
            <xsl:otherwise>
              Currently not assigned to anyone.
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </td>
    </tr>
  </xsl:template>

  <!-- These errors go into the other errors category -->
  <xsl:template match="tb:BuildInformationNode[@Type = 'BuildError' and (count(@ParentId) = 0 or @ParentId = 0)]">
    <tr>
      <td style="padding-left:2em; color:#C00;">
        <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'Message']/@Value"/>
      </td>
    </tr>
  </xsl:template>

  <!-- These errors are associated with a project which was built -->
  <xsl:template match="tb:BuildInformationNode[@Type = 'BuildError' and count(@ParentId) > 0 and @ParentId > 0]">
    <tr>
      <td style="padding-left:2em; color:#C00;">
        <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'File']/@Value"/> (<xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'LineNumber']/@Value"/>): <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'Message']/@Value"/>
      </td>
    </tr>
  </xsl:template>

  <xsl:template match="tb:BuildInformationNode[@Type = 'BuildProject']">
    <xsl:variable name="nodeId" select="@NodeId"/>
    <tr>
      <td>
        <span _locID="ProjectSummary">
          <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'ServerPath']/@Value"/> - 
          <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'CompilationErrors']/@Value"/> error(s),
          <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'CompilationWarnings']/@Value"/> warning(s)
        </span>
      </td>
    </tr>
    <xsl:apply-templates select="../tb:BuildInformationNode[@Type = 'BuildError' and @ParentId = $nodeId]"/>
  </xsl:template>

  <xsl:template match="tb:BuildInformationNode[@Type = 'ConfigurationSummary']">
    <xsl:variable name="platform" select="tb:Fields/tb:InformationField[@Name = 'Platform']/@Value" />
    <xsl:variable name="flavor" select="tb:Fields/tb:InformationField[@Name = 'Flavor']/@Value" />
    <xsl:value-of select="$flavor"/> | <xsl:value-of select="$platform"/>
    <table style="padding-left:2em;">
      <tr>
        <td>
          <span _locID="ErrorsAndWarnings">
            <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'TotalCompilationErrors']/@Value"/> error(s),
            <xsl:value-of select="tb:Fields/tb:InformationField[@Name = 'TotalCompilationWarnings']/@Value"/> warning(s)
          </span>
        </td>
      </tr>
      <xsl:apply-templates select="../tb:BuildInformationNode[@Type = 'BuildProject'][count(tb:Fields/tb:InformationField[@Name = 'Platform' and @Value = $platform]) > 0][count(tb:Fields/tb:InformationField[@Name = 'Flavor' and @Value = $flavor]) > 0]"/>
    </table>
  </xsl:template>

  <xsl:template match="tb:QueuedBuild">
    <xsl:variable name="requestId" select="@Id"/>
    <xsl:variable name="changesetId" select="../../tb:Build/tb:Information/tb:BuildInformationNode[@Type = 'CheckInOutcome'][count(tb:Fields/tb:InformationField[@Name = 'RequestId' and @Value = $requestId]) > 0]/tb:Fields/tb:InformationField[@Name = 'ChangesetId']/@Value"/>
    <tr>
      <td style="padding-right:2em;">
        <span _locID="RequestHeader">
          Request <xsl:value-of select="$requestId"/>
        </span>
      </td>
      <td style="padding-right:2em;">
        <xsl:value-of select="@RequestedForDisplayName"/>
      </td>
      <xsl:choose>
        <xsl:when test="@Reason = 'CheckInShelveset'">
          <xsl:choose>
            <xsl:when test="$changesetId > 0">
              <td style="padding-right:2em;">
                <!-- _locID_text="RequestCheckInCommitted" -->Check-in Committed
              </td>
            </xsl:when>
            <xsl:when test="$changesetId = 0">
              <td style="padding-right:2em;">
                <!-- _locID_text="RequestNoChangesCheckedIn" -->No Changes Checked In
              </td>
            </xsl:when>
            <xsl:otherwise>
              <td style="padding-right:2em; color:#C00;">
                <!-- _locID_text="RequestCheckInRejected" -->Check-in Rejected
              </td>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <td style="padding-right:2em;">
            <!-- _locID_text="RequestCompleted" -->Completed
          </td>
        </xsl:otherwise>
      </xsl:choose>
    </tr>
  </xsl:template>

  <xsl:template name="linefeed2br">
    <xsl:param name="StringToTransform"/>
    <xsl:choose>
      <!-- Does the string contain a linefeed? -->
      <xsl:when test="contains($StringToTransform,'&#10;')">
        <!-- find the linefeed and output the substring that comes before it -->
        <xsl:value-of select="substring-before($StringToTransform,'&#10;')"/>
        <!-- remove the line feed and replace with a <br />  -->
        <br/>
        <!-- repeat -->
        <xsl:call-template name="linefeed2br">
          <xsl:with-param name="StringToTransform">
            <xsl:value-of select="substring-after($StringToTransform,'&#10;')"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <!-- string does not contain newline, so just output it -->
      <xsl:otherwise>
        <xsl:value-of select="$StringToTransform"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Convert seconds to minutes with one decimal place -->
  <xsl:template name="durationToMinutes">
    <xsl:param name="seconds"/>
    <!-- Compute tenths of minutes, round up, and divide by 10 to get minutes -->
    <xsl:value-of select ="ceiling($seconds div 6) div 10"/>
  </xsl:template>

  <!-- Format a date/time in a format consistent with code review -->
  <xsl:template name="formatDateTime">
    <xsl:param name="dateTime"/>

    <xsl:value-of select="ms:format-date($dateTime, 'ddd MM/dd/yyyy')"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="ms:format-time($dateTime, 'hh:mm tt')"/>
  </xsl:template>

</xsl:stylesheet>
