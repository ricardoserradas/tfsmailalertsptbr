<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ms="urn:schemas-microsoft-com:xslt" version="1.0">
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
                    Code Review de <xsl:value-of select="/CodeReviewChangedEvent/SourceWorkItem/Title"/>
                </title>
            </head>
            <body>
                <xsl:apply-templates select="*"/>
            </body>
        </html>
    </xsl:template>

    <!-- Define a key for the changes based on the parent path so we can group -->
    <xsl:key name="items-by-folder" match="ReviewContext/Changes/Change" use="translate(@ParentPath,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    <xsl:key name="discussions-by-item" match="/CodeReviewChangedEvent/Discussions/ReviewDiscussion" use="@FilePath"/>
    <xsl:template match="CodeReviewChangedEvent">
        <xsl:variable name="changedBy" select="ChangedBy"/>
        <xsl:variable name="subscriber" select="Subscriber"/>
        <xsl:variable name="workItemId" select="SourceWorkItem/Id" />
        <xsl:variable name="added" select="Reviewers/Reviewer[@Status = 'Added']/@Name"/>
        <xsl:variable name="removed" select="Reviewers/Reviewer[@Status = 'Removed']/@Name"/>
        <xsl:variable name="reason" select="Reviewers/Reviewer[@Status = 'Reviewed' and @Name=$changedBy]/@Resolution"/>
        <xsl:variable name="closingReason">
            <xsl:if test="count(ClosingComment) > 0 and string-length(ClosingComment) > 0">
                <span _locID="ClosingReason">
                    (Razão: <xsl:value-of select="ClosingComment" />)
                </span>
            </xsl:if>
        </xsl:variable>
        <p style="margin-bottom: .5em;padding: .5em 1em;background-color: #ffc;border: solid 1px #999999;">
            <xsl:choose>
                <xsl:when test="Action = 'Abandoned'">
                    <span _locID="TitleAbandoned">
                        <strong>
                            <xsl:value-of select="$changedBy"/>
                        </strong> abandonou a revisão.
                    </span>
                </xsl:when>
                <xsl:when test="Action = 'Completed'">
                    <span _locID="TitleCompleted">
                        <strong>
                            <xsl:value-of select="$changedBy"/>
                        </strong> fechou a revisão.
                    </span>
                </xsl:when>
                <xsl:when test="Action = 'Declined'">
                    <span _locID="TitleDeclined">
                        <strong>
                            <xsl:value-of select="$changedBy"/>
                        </strong> recusou <xsl:value-of select="$closingReason" />.
                    </span>
                </xsl:when>
                <xsl:when test="Action = 'Discussion'">
                    <xsl:variable name="newCommentCount" select="count(Discussions/ReviewDiscussion/Comments//ReviewComment[@IsNew])" />
                    <xsl:variable name="commentText">
                        <xsl:choose>
                            <xsl:when test="$newCommentCount = 1">
                                <!-- _locID_text="Comment1" --><xsl:value-of select="$newCommentCount" /> comentário</xsl:when>
                            <xsl:when test="$newCommentCount > 1">
                                <!-- _locID_text="CommentN" --><xsl:value-of select="$newCommentCount" /> comentários</xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:choose>
                        <xsl:when test="$newCommentCount > 0">
                            <span _locID="TitleDiscussion1">
                                <strong>
                                    <xsl:value-of select="$changedBy"/>
                                </strong> postou <xsl:value-of select="$commentText" />.
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span _locID="TitleDiscussion2">
                                <strong>
                                    <xsl:value-of select="$changedBy"/>
                                </strong> postou um feedback.
                            </span>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="Action = 'Requested'">
                    <span _locID="TitleRequested">
                        O seu feedback foi solicitado por <strong><xsl:value-of select="RequestedBy"/></strong>.
                    </span>
                </xsl:when>
                <xsl:when test="Action = 'Accepted'">
                    <span _locID="TitleAccepted">
                        <strong>
                            <xsl:value-of select="ChangedBy"/>
                        </strong> aceitou.
                    </span>
                </xsl:when>
                <xsl:when test="Action = 'Reviewed'">
                    <span>
                        <strong>
                            <xsl:value-of select="ChangedBy"/>
                        </strong> 
                        <xsl:choose>
                            <xsl:when test="$reason = 'LooksGood'">
                                <span _locID="ReviewerFinishedLooksGood"> finalizou (parece bom)</span>
                            </xsl:when>
                            <xsl:when test="$reason = 'WithComments'">
                                <span _locID="ReviewerFinishedWithComments"> finalizou (com ressalvas)</span>
                            </xsl:when>
                            <xsl:when test="$reason = 'NeedsWork'">
                                <span _locID="ReviewerFinishedNeedsWork"> finalizou (precisa de mais trabalho)</span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span _locID="ReviewerFinished"> finalizou</span>
                            </xsl:otherwise>
                        </xsl:choose>.
                    </span>
                </xsl:when>
                <xsl:when test="Action = 'ReviewerAdded'">
                    <xsl:choose>
                        <xsl:when test="$added = $subscriber">
                            <xsl:choose>
                                <xsl:when test="$added = $changedBy">
                                    <span _locID="TitleAdded">
                                        O seu feedback foi solicitado.
                                    </span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span _locID="TitleAddedBy">
                                        O seu feedback foi solicitado por <strong><xsl:value-of select="$changedBy"/></strong>.
                                    </span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="$added = $changedBy">
                                    <span _locID="TitleAdded1">
                                        <strong>
                                            <xsl:value-of select="$added"/>
                                        </strong> foi adicionado.
                                    </span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span _locID="TitleAddedBy1">
                                        <strong>
                                            <xsl:value-of select="$added"/>
                                        </strong> foi adicionado por <strong><xsl:value-of select="$changedBy"/></strong>.
                                    </span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="Action = 'ReviewerRemoved'">
                    <xsl:choose>
                        <xsl:when test="$removed = $subscriber">
                            <xsl:choose>
                                <xsl:when test="$removed = $changedBy">
                                    <span _locID="TitleRemoved">
                                        Você foi removido <xsl:value-of select="$closingReason" />.
                                    </span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span _locID="TitleRemovedBy">
                                        Você foi removido por <strong>
                                            <xsl:value-of select="$changedBy"/>
                                        </strong> <xsl:value-of select="$closingReason" />.
                                    </span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:choose>
                                <xsl:when test="$removed = $changedBy">
                                    <span _locID="TitleRemoved1">
                                        <strong>
                                            <xsl:value-of select="$removed"/>
                                        </strong> foi removido <xsl:value-of select="$closingReason" />.
                                    </span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span _locID="TitleRemovedBy1">
                                        <strong>
                                            <xsl:value-of select="$removed"/>
                                        </strong> foi removido por <strong>
                                            <xsl:value-of select="$changedBy"/>
                                        </strong> <xsl:value-of select="$closingReason" />.
                                    </span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
            <div>
                <span>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="Uri" />
                        </xsl:attribute>
                        <!-- _locID_text="OpenInVS" -->Abrir mudanças e comentários no Visual Studio</a>
                    |
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="WebAccessUri" />
                        </xsl:attribute>
                        <!-- _locID_text="OpenInTswa" -->Abrir mudanças no Web Access</a>
                </span>
            </div>
          <div style="margin-left:0em">
            Review solicitada por <xsl:value-of select="RequestedBy"/>
          </div>
        </p>
        <h2 style="font-size: 12pt; margin-bottom: 0em;">
            <span _locID="Reviewers">Revisores</span>
        </h2>
        <div style="margin-left:1em">
            <xsl:choose>
                <xsl:when test="count(Reviewers/Reviewer[@Status != 'Removed']) + count(DeclinedReviewers/Reviewer) > 0">
                    <table style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 10pt;">
                        <xsl:apply-templates select="Reviewers/Reviewer[@Status != 'Removed']">
                            <xsl:sort select="@Status"/>
                            <xsl:sort select ="@Name"/>
                        </xsl:apply-templates>
                        <xsl:apply-templates select="DeclinedReviewers/Reviewer">
                            <xsl:sort select="@Status"/>
                            <xsl:sort select ="@Name"/>
                        </xsl:apply-templates>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <span _locID="None">Nenhum</span>
                </xsl:otherwise>
            </xsl:choose>
        </div>
        <h2 style="font-size: 12pt; margin-bottom: 0em;">
            <span _locID="AssociatedWorkItems">Work Items Relacionados</span>
        </h2>
        <div style="margin-left:1em">
            <xsl:choose>
                <xsl:when test="count(AssociatedWorkItems/WorkItem)">
                    <table style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 10pt;">
                        <xsl:apply-templates select="AssociatedWorkItems/WorkItem">
                            <xsl:sort select="Id"/>
                            <xsl:sort select ="Title"/>
                        </xsl:apply-templates>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <span _locID="None">Nenhum</span>
                </xsl:otherwise>
            </xsl:choose>
        </div>
        <h2 style="font-size: 12pt; margin-bottom: 0em;">
            <span _locID="OverallComments">Comentários Gerais</span>
        </h2>
        <div style="margin-left:1em">
            <xsl:choose>
                <xsl:when test="count(Discussions/ReviewDiscussion[count(@FilePath) = 0]) > 0">
                    <xsl:for-each select="Discussions/ReviewDiscussion[count(@FilePath) = 0]">
                        <xsl:apply-templates select="Comments" />
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <span _locID="None">Nenhum</span>
                </xsl:otherwise>
            </xsl:choose>
        </div>        
        <h2 style="font-size: 12pt; margin-bottom: 0em;">
            <span _locID="FilesToReview">Arquivos a serem revisados e seus comentários</span>
        </h2>
        <div style="margin-left:1em">
            <xsl:choose>
                <xsl:when test="count(ReviewContext/Changes/Change) > 0">
                    <xsl:for-each select="ReviewContext/Changes/Change[ms:string-compare(@ParentPath, preceding-sibling::Change/@ParentPath,'','i')!=0]">
                      <xsl:variable name="ParentPath" select="translate(@ParentPath,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
                      <!-- need to take the first value from the key -->
                      <xsl:if test="generate-id(.) = generate-id(key('items-by-folder', $ParentPath)[1])">
                        <div>
                          <xsl:value-of select="@ParentPath"/>
                        </div>
                        <div style="margin-left: 1em;margin-bottom: 0.5em">
                          <xsl:for-each select="key('items-by-folder', $ParentPath)">
                            <div>
                              <xsl:apply-templates select="."/>
                            </div>
                            <xsl:if test="count(key('discussions-by-item', concat(@ParentPath,'/',@ChildItem)))>0">
                              <div style=" margin-left: 1em; margin-top: 0.5em; margin-bottom: 0.5em">
                                <xsl:apply-templates select="key('discussions-by-item', concat(@ParentPath,'/',@ChildItem))">
                                  <xsl:sort select ="@StartLine" data-type ="number"/>
                                </xsl:apply-templates>
                              </div>
                            </xsl:if>
                          </xsl:for-each>
                        </div>
                      </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <span _locID="None">Nenhum</span>
                </xsl:otherwise>
            </xsl:choose>
        </div>
        <!-- Apply the standard TFS footer -->
        <xsl:call-template name="footer">
            <xsl:with-param name="format" select="'html'"/>
            <xsl:with-param name="alertOwner" select="Subscriber"/>
            <xsl:with-param name="timeZoneOffset" select="TimeZoneOffset"/>
            <xsl:with-param name="timeZoneName" select="TimeZone"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="Reviewer">
        <tr>
            <td style="padding-right:2em">
                <xsl:value-of select="@Name"/>
            </td>
            <td>
                <xsl:choose>
                    <xsl:when test="@Status = 'NotStarted' or @Status = 'Added'">
                        <span _locID="ReviewerRequested">Solicitado</span>
                    </xsl:when>
                    <xsl:when test="@Status = 'Accepted'">
                        <span _locID="ReviewerAccepted">Aceito</span>
                    </xsl:when>
                  <xsl:when test="@Status = 'Declined'">
                    <span _locID="ReviewerDeclined">Negado</span>
                  </xsl:when>
                  <xsl:when test="@Status = 'Reviewed'">
                        <xsl:choose>
                            <xsl:when test="@Resolution = 'LooksGood'">
                                <span _locID="ReviewerClosedLooksGood">Finalizado (Parece Bom)</span>
                            </xsl:when>
                            <xsl:when test="@Resolution = 'WithComments'">
                                <span _locID="ReviewerClosedWithComments">Finalizado (Com Ressalvas)</span>
                            </xsl:when>
                            <xsl:when test="@Resolution = 'NeedsWork'">
                                <span _locID="ReviewerClosedNeedsWork">Finalizado (Precisa de mais trabalho)</span>
                            </xsl:when>
                            <xsl:otherwise>
                                <span _locID="ReviewerClosed">Finalizado</span>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                </xsl:choose>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="Text">
        <xsl:call-template name="linefeed2br">
            <xsl:with-param name="StringToTransform" select="."/>
        </xsl:call-template>
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

    <xsl:template match="Change">
        <span><xsl:if test ="@ChangeType='Delete'"><xsl:attribute name ="style">text-decoration: line-through;</xsl:attribute></xsl:if>
            <xsl:value-of select="@ChildItem"/>
            <xsl:choose>
                <xsl:when test="@ChangeType='Edit'"></xsl:when>
                <xsl:when test="@ChangeType='Delete'"></xsl:when>
                <xsl:when test="contains(@ChangeType,'Add')"> [+]</xsl:when>
                <xsl:when test="contains(@ChangeType,'Rename')"> [Renomeado]</xsl:when>
                <xsl:otherwise> [Outro]</xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <!-- Recursive template for displaying a discussion hierarchy -->
    <xsl:template match="ReviewComment">
        <div>
            <xsl:choose>
                <xsl:when test="count(@IsNew) > 0">
                    <xsl:attribute name="style">margin-top: 0.25em; margin-bottom: 0.25em; color: black</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="style">margin-top: 0.25em; margin-bottom: 0.25em; color: #888</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <strong>
                <xsl:value-of select="@Author"/>
            </strong>
            <div>
                <xsl:apply-templates select="Text" />
            </div>
            <xsl:if test ="../../@StartLine > 0">Linha <xsl:value-of select="../../@StartLine"/> | </xsl:if><xsl:value-of select="@PublishDateText"/>
            <xsl:if test ="count(Replies/ReviewComment)>0">
                <div style="border-left: 4px solid #ccc; padding-left: 1em;">
                    <xsl:apply-templates select="Replies/*" />
                </div>
            </xsl:if>
        </div>
    </xsl:template>
    <!-- Template for displaying an associated work item -->
    <xsl:template match="WorkItem">
        <tr>
            <td style="padding-right:2em">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="WebAccessUri"/></xsl:attribute>                    
                    <xsl:value-of select ="Id"/>
                </a>
            </td>
            <td style="padding-right:2em">
                <xsl:value-of select ="WorkItemType"/>
            </td>
            <td style="padding-right:2em">
                <xsl:value-of select ="Title"/>
            </td>
        </tr>
    </xsl:template>    
</xsl:stylesheet>
