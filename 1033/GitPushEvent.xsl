<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ms="urn:schemas-microsoft-com:xslt" version="1.0" exclude-result-prefixes="ms">
  <!-- Common TeamSystem elements -->
  <xsl:import href="TeamFoundation.xsl"/>
  <xsl:output method = "html" doctype-public ="-//W3C//DTD HTML 4.01//EN"/>
  <xsl:output encoding="utf-8" indent="yes" method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <style type="text/css">
          body {
          font-family: 'Segoe UI', sans-serif;
          max-width: 1000px;
          margin-left: auto;
          margin-right: auto;
          }
          h1, h2, h3, h4, p, div {
          padding-left: 30px;
          }
          h1, h2 {
          font-family: 'Segoe UI Light', sans-serif;
          margin-bottom: -10px;
          }
          h1 {
          padding-left: 10px;
          }
          a {
          color: dodgerblue;
          text-decoration: none;
          }
          a:hover {
          text-decoration: underline;
          }
          table {
          margin-top: 16px;
          margin-left: 20px;
          border: 0px;
          }
          td {
          padding-left: 10px;
          padding-right: 16px;
          padding-top: 0px;
          padding-bottom: 0px;
          }
          ul
          {
          list-style-type: none;
          }
          .subdued {
          color: grey;
          }
          .important {
          color: crimson;
          }
          .footer {
          color: grey;
          font-size: 8pt;
          padding-top: 20px;
          padding-left: 10px;
          }
          .comment {
          white-space: pre;
          }
          .shortIdSpan {
          width: 6em;
          display: inline-block
          }

        </style>
        <title>
          <!-- _locID_text="push_notification_for_repository"--> Notificação de Push para o Repositório <xsl:value-of select="/GitPushEvent/PushNotification/RepositoryName"/>
        </title>
      </head>
      <body>
        <xsl:apply-templates select="*"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="GitPushEvent">
    <xsl:variable name="numRefsUpdated" select="count(/GitPushEvent/PushNotification/RefUpdateResults/GitPushRefUpdate)" />
    <h1>
      <xsl:value-of select="$numRefsUpdated"/>
      <xsl:choose>
        <xsl:when test="$numRefsUpdated > 1">
          <!-- _locID_text="references_were"--> referências foram
        </xsl:when>
        <xsl:otherwise>
          <!-- _locID_text="reference_was"--> referência é
        </xsl:otherwise>
      </xsl:choose>
      <!-- _locID_text="pushed_to_the"--> push realizado para <xsl:call-template name="link">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="link" select="/GitPushEvent/RepositoryUri"/>
        <xsl:with-param name="displayText" select="/GitPushEvent/PushNotification/RepositoryName"/>
      </xsl:call-template>
      <!-- _locID_text="repository"--> repositório.
    </h1>
    <p>
      <span class="subdued">
        <!-- _locID_text="pushed_by"--> Push realizado por </span>
      <a>
        <xsl:attribute name="HREF">mailto:<xsl:value-of select="/GitPushEvent/PushNotification/PusherEmail"/></xsl:attribute>
        <xsl:attribute name="title">mailto:<xsl:value-of select="/GitPushEvent/PushNotification/PusherEmail"/></xsl:attribute>
        <xsl:value-of select="/GitPushEvent/PushNotification/UserDisplayName"/>
      </a>
      <span class="subdued">
        - <xsl:value-of select="/GitPushEvent/PushNotification/PushTimeString"/>
      </span>
    </p>
    <!--Ref Summary-->
    <table>
      <xsl:for-each select="/GitPushEvent/PushNotification/RefUpdateResults/GitPushRefUpdate">
        <tr>
          <td>
            <xsl:call-template name="link">
              <xsl:with-param name="format" select="'html'"/>
              <xsl:with-param name="link" select="RefUrl"/>
              <xsl:with-param name="displayText" select="RefName"/>
            </xsl:call-template> 
            <xsl:choose>
              <xsl:when test="OldId = '0000000000000000000000000000000000000000'">
                <!-- _locID_text="was_created_at"--> foi criado em
                <xsl:call-template name="link">
                  <xsl:with-param name="format" select="'html'"/>
                  <xsl:with-param name="link" select="NewIdUrl"/>
                  <xsl:with-param name="displayText" select="ShortNewId"/>
                </xsl:call-template>.
              </xsl:when>
              <xsl:when test="NewId = '0000000000000000000000000000000000000000'">
                <!-- _locID_text="was_deleted"--> foi excluído.
              </xsl:when>
              <xsl:otherwise>
                <!-- _locID_text="was_updated_to"--> foi atualizado para
                <xsl:call-template name="link">
                  <xsl:with-param name="format" select="'html'"/>
                  <xsl:with-param name="link" select="NewIdUrl"/>
                  <xsl:with-param name="displayText" select="ShortNewId"/>
                </xsl:call-template>.
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </xsl:for-each>
    </table>
    <!--Ref details-->
    <xsl:for-each select="/GitPushEvent/PushNotification/RefUpdateResults/GitPushRefUpdate">
      <xsl:apply-templates select="." />
    </xsl:for-each>

    <xsl:call-template name="footer">
      <xsl:with-param name="format" select="'html'"/>
      <xsl:with-param name="alertOwner" select="Subscriber"/>
      <xsl:with-param name="timeZoneOffset" select="TimeZoneOffset"/>
      <xsl:with-param name="timeZoneName" select="TimeZoneName"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="GitPushRefUpdate">
    <xsl:variable name="numCommitDetails" select="count(CommitDetails/GitPushCommitData)" />
    <xsl:if test="NewId != '0000000000000000000000000000000000000000' and OldId != '0000000000000000000000000000000000000000'">
      <h1>
      <!-- _locID_text="Reference"--> <xsl:call-template name="link">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="link" select="RefUrl"/>
        <xsl:with-param name="displayText" select="RefName"/>
      </xsl:call-template>
        <!-- _locID_text="was_updated_to"--> foi atualizado para
        <xsl:call-template name="link">
          <xsl:with-param name="format" select="'html'"/>
          <xsl:with-param name="link" select="NewIdUrl"/>
          <xsl:with-param name="displayText" select="ShortNewId"/>
        </xsl:call-template>.        
      <br/>
      </h1>
      <h2>
        <xsl:value-of select="TotalCommits"/>
        <xsl:choose>
          <xsl:when test="TotalCommits = 1">
            <!-- _locID_text="commit_included_in_this_change"--> commit incluído nesta mudança.
          </xsl:when>
          <xsl:otherwise>
            <!-- _locID_text="commits_included_in_this_change"--> commits incluídos nesta mudança.
          </xsl:otherwise>
        </xsl:choose>
        <br/>
      </h2>

      <!--Commit summary (only if there's more than 1)-->
      <xsl:if test="TotalCommits != 1">
        <ul>
          <xsl:for-each select="CommitDetails/GitPushCommitData">
            <li>
              <span class="shortIdSpan">
                <xsl:call-template name="link">
                  <xsl:with-param name="format" select="'html'"/>
                  <xsl:with-param name="link" select="IdUrl"/>
                  <xsl:with-param name="displayText" select="ShortId"/>
                </xsl:call-template>:
              </span> <xsl:value-of select="ShortComment"/>
            <br/>
            </li>
            <xsl:if test="$numCommitDetails > 5">
              <li>
                <span class="subdued">
                  <!-- _locID_text="authored_by"--> Autoria de </span> <xsl:value-of select="Author"/> - <xsl:value-of select="AuthorTimeString"/>
              <br/>              
              </li>         
            </xsl:if>
          </xsl:for-each>
        </ul>
      </xsl:if>

      <!--Commit Details-->
      <xsl:choose>
        <xsl:when test="6 > $numCommitDetails">
          <xsl:for-each select="CommitDetails/GitPushCommitData">
            <h2>
              <!-- _locID_text="Commit"--> Commit <xsl:call-template name="link">
                <xsl:with-param name="format" select="'html'"/>
                <xsl:with-param name="link" select="IdUrl"/>
                <xsl:with-param name="displayText" select="ShortId"/>
              </xsl:call-template>: <xsl:value-of select="ShortComment"/>
            </h2>
            <p>
              <span class="subdued">
                <!-- _locID_text="authored_by"--> Autoria de </span>
              <xsl:value-of select="Author"/>
              <span class="subdued">
                - <xsl:value-of select="AuthorTimeString"/><br/>              
              </span>                 
            </p>
            <p>
              <span class="comment">
                <xsl:value-of select="Comment"/>
              </span>
            <br/>
            </p>            
            <xsl:if test="count(CommitDiffs/GitDiffEntryData) > 0">
              <h3>
                <!-- _locID_text="Changes"--> Mudanças
                <br/>
              </h3>
              
              <ul>
                <xsl:for-each select="CommitDiffs/GitDiffEntryData">
                  <li>
                    <span class="shortIdSpan">
                      <xsl:choose>
                        <xsl:when test="ChangeType = 'Add'">
                          <!-- _locID_text="add"--> adição </xsl:when>
                        <xsl:when test="ChangeType = 'Delete'">
                          <!-- _locID_text="delete"--> exclusão </xsl:when>
                        <xsl:otherwise>
                          <!-- _locID_text="edit"--> edição </xsl:otherwise>
                      </xsl:choose>
                    </span>
                    <xsl:call-template name="link">
                      <xsl:with-param name="format" select="'html'"/>
                      <xsl:with-param name="link">
                        <xsl:value-of select="FileChangeUri" disable-output-escaping="yes"/>
                      </xsl:with-param>
                      <xsl:with-param name="displayText" select="RelativePath"/>
                    </xsl:call-template>
                  <br/>
                  </li>                  
                </xsl:for-each>
              </ul>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="TotalCommits > $numCommitDetails">
          <!-- _locID_text="view_all"--> Ver tudo <xsl:call-template name="link">
            <xsl:with-param name="format" select="'html'"/>
            <xsl:with-param name="link" select="RefUrl"/>
            <xsl:with-param name="displayText" select="TotalCommits"/>
          </xsl:call-template> <!-- _locID_text="commits_with_elipses"--> commits...
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
