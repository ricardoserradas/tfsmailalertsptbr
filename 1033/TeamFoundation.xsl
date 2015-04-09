<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>
<!--
This style sheet contains common formatting and handling elements for Team Foundation. 

Templates:

    footer (format, alertOwner, timeZoneName, timeZoneOffset)

    link(format, link, displayText):
      Generates a link
    where
        format: html or text
        link: Url
        displayText:
-->

<!-- Common strings -->
<xsl:variable name="morePrompt"><!--_locID_text="morePrompt"-->Mais ...</xsl:variable>
<xsl:variable name="FileType"><!--_locID_text="FileType"-->Arquivo</xsl:variable>
<xsl:variable name="FolderType"><!--_locID_text="FolderType"-->Pasta</xsl:variable>
<xsl:variable name="datetime"><!--_locID_text="datetime"-->- Todas as datas e horas são exibidas em UTC</xsl:variable>
<xsl:variable name="tfUrl" select="'http://go.microsoft.com/fwlink/?LinkID=129550'"/>
<xsl:variable name="tmText"><!--_locID_text="tmText"-->Microsoft Visual Studio&#174; Team Foundation Server</xsl:variable>
<xsl:variable name="textSeparatorLong" select="'----------------------------------------------------------------------'"/>
<xsl:variable name="by"><!--_locID_text="by"-->Provido por </xsl:variable>
<xsl:variable name="reason"><!--_locID_text="reason"-->- Você está recebendo esta notificação por conta de um alerta criado por </xsl:variable>
<xsl:variable name="Error"><!--_locID_text="Error"-->Um erro ocorreu enquanto sua requisição era processada. Isto pode ser um erro temporário e tentar novamente pode ajudar. Se o erro persistir e você achar que é necessário dar mais atenção, por favor, envie esta mensagem e a(s) mensagem(ns) de erro que aparece(m) para o grupo de administração</xsl:variable>
<xsl:variable name="DetailedErrorHeader"><!--_locID_text="DetailedErrorHeader"-->Mensagem(ns) de erro detalhada(s) (para o grupo administrativo):</xsl:variable>
<!-- Item information webview title -->
<xsl:variable name="ChangesetViewTitle"><!-- _locID_text="ChangesetViewTitle" -->Informações do Changeset</xsl:variable>
<xsl:variable name="ShelvesetViewTitle"><!-- _locID_text="ShelvesetViewTitle" -->Informações do Shelveset</xsl:variable>
<xsl:variable name="CheckinActionResolve"><!-- _locID_text="CheckinActionResolve" -->Resolver</xsl:variable>
<xsl:variable name="CheckinActionAssociate"><!-- _locID_text="CheckinActionAssociate" -->Associar</xsl:variable>

<!-- Footer -->
<xsl:template name="footer">
<xsl:param name="format"/>
<xsl:param name="alertOwner"/>
<xsl:param name="timeZoneName"/>
<xsl:param name="timeZoneOffset"/>
<xsl:choose>
    <xsl:when test="$format='html'">
        <div class="footer">
        <br/>
        <xsl:text><!-- _locID_text="notes" -->Notas:</xsl:text>
        <br/>
            <!-- All dates and times are shown in UTC 
                 All dates and times are shown in UTC-07:00:00 Pacific Daylight Time
                 All dates and times are shown in UTC+05:30:00 India Standard Time -->
        <xsl:if test="string-length($timeZoneName) > 0">
            <xsl:value-of select="$datetime"/>
            <xsl:if test="not(contains($timeZoneOffset, '00:00:00'))">
                <xsl:value-of select="$timeZoneOffset"/>
                <xsl:value-of select="concat(' ', $timeZoneName)"/>
            </xsl:if>
            <br/>
        </xsl:if>
        <xsl:if test="string-length($alertOwner) > 0">
            <xsl:value-of select="$reason"/>
            <xsl:value-of select="$alertOwner"/>
            <br/>
        </xsl:if>
        <xsl:value-of select="$by"/>
        <xsl:call-template name="link">
            <xsl:with-param name="format" select="$format"/>
            <xsl:with-param name="link" select="$tfUrl"/>
            <xsl:with-param name="displayText" select="$tmText"/>
        </xsl:call-template>
        </div>
    </xsl:when>
<xsl:when test="$format='text'">
<xsl:text><!-- _locID_text="notesUpper" -->&#xA;--------------- NOTAS ----------------&#xA;</xsl:text>
<xsl:if test="string-length($timeZoneName) > 0">
<xsl:value-of select="$datetime"/><xsl:if test="not(contains($timeZoneOffset, '00:00:00'))"><xsl:value-of select="$timeZoneOffset"/><xsl:value-of select="concat(' ', $timeZoneName)"/></xsl:if>
<xsl:text>&#xA;</xsl:text>
</xsl:if>
<xsl:if test="string-length($alertOwner) > 0">
<xsl:value-of select="$reason"/>
<xsl:value-of select="$alertOwner"/>
<xsl:text>&#xA;</xsl:text>
</xsl:if>
<xsl:value-of select="$by"/>
<xsl:call-template name="link">
<xsl:with-param name="format" select="$format"/>
<xsl:with-param name="link" select="$tfUrl"/>
<xsl:with-param name="displayText" select="$tmText"/>
</xsl:call-template>
    </xsl:when>
</xsl:choose>
</xsl:template> <!-- footer -->

<xsl:template name="link">
    <xsl:param name="format"/>
    <xsl:param name="link"/>
    <xsl:param name="embolden"/>
    <xsl:param name="fontSize"/>
    <xsl:param name="displayText"/>
    <xsl:choose>
        <xsl:when test="$format='html'">
            <a>
                <xsl:attribute name="HREF">
                    <xsl:value-of select="$link"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:value-of select="$displayText"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="$embolden='true'">
                        <b>
                        <xsl:value-of select="$displayText"/>
                        </b>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$displayText"/>
                    </xsl:otherwise>
                </xsl:choose>
            </a>
        </xsl:when>
<xsl:when test="$format='text'">
<xsl:value-of select="$displayText"/><xsl:value-of disable-output-escaping="yes" select="concat(' (',$link,')')"/>
</xsl:when>
    </xsl:choose>
    </xsl:template>
<xsl:template name="style">
  <STYLE TYPE="text/css">
    body, input, button
    {
    color: black;
    background-color: white;
    font-family: Verdana,Arial,Helvetica;
    font-size: x-small;
    }
    p
    {
    color: #666666;
    }
    h1
    {
    color: #666666;
    font-size: medium;
    }
    h2
    {
    color: black;
    }
    table
    {
    border-collapse: collapse;
    border-width: 0;
    border-spacing: 0;
    width: 90%;
    table-layout: auto;
    }
    pre
    {
    word-wrap: break-word;
    font-size: x-small;
    font-family: Verdana,Arial,Helvetica;
    display: inline;
    }
    table.WithBorder
    {
    border-style: solid;
    border-color: #F1EFE2;
    border-width: 1px;
    border-collapse: collapse;
    width: 90%;
    }
    TD
    {
    vertical-align: top;
    font-size: x-small;
    }
    TD.PropName
    {
    vertical-align: top;
    font-size: x-small;
    white-space: nowrap;
    background-color: #FFF;
    border-top: 1px solid #F1EFE2;
    }
    TD.PropValue
    {
    font-size: x-small;
    border-top: 1px dotted #F1EFE2;
    }
    TD.Col1Data
    {
    font-size: x-small;
    border-style: solid;
    border-color: #F1EFE2;
    border-width: 1px;
    background: #F9F8F4;
    width: auto;
    }
    TD.ColData
    {
    font-size: x-small;
    border-style: solid;
    border-color: #F1EFE2;
    border-width: 1px;
    }
    TD.ColDataXSmall
    {
    font-size: x-small;
    border-style: solid;
    border-color: #F1EFE2;
    border-width: 1px;
    width: 5%;
    }
    TD.ColDataSmall
    {
    font-size: x-small;
    border-style: solid;
    border-color: #F1EFE2;
    border-width: 1px;
    width: 10%;
    }
    TD.ColHeadingXSmall
    {
    background-color: #F1EFE2;
    border-style: solid;
    border-color: #F1EFE2;
    border-width: 1px;
    font-size: x-small;
    width: 5%;
    }
    TD.ColHeadingSmall
    {
    background-color: #F1EFE2;
    border-style: solid;
    border-color: #F1EFE2;
    border-width: 1px;
    font-size: x-small;
    width: 10%;
    }
    TD.ColHeadingMedium
    {
    background: #F1EFE2;
    border-style: solid;
    border-color: #F1EFE2;
    border-width: 1px;
    font-size: x-small;
    width: 200px;
    }
    TD.ColHeading
    {
    font-size: x-small;
    border-style: solid;
    border-color: #F1EFE2;
    border-width: 1px;
    background: #F1EFE2;
    width: auto;
    }
    .Title
    {
    width:100%;
    font-size: medium;
    }
    .footer
    {
    width:100%;
    font-size: xx-small;
    }
  </STYLE>
</xsl:template>

<!-- Team Foundation XSL templates -->
<xsl:template name="TeamFoundationItem">
<xsl:param name="format"/>
<xsl:param name="Item"/>
<xsl:choose>
    <xsl:when test="$format='html'">
    <xsl:if test="string-length(Item/@title) > 0">
        <title><xsl:value-of select="Item/@title"/></title>
        <div class="Title"><xsl:value-of select="Item/@title"/></div>
    </xsl:if>
    <xsl:if test="string-length(Item/@title) = 0">
        <title><xsl:value-of select="Item/@item"/></title>
        <div class="Title"><xsl:value-of select="Item/@item"/></div>
    </xsl:if>
    <b _locID="summary">Somário</b>
    <table>
        <tr>
            <td class="PropName" _locID="serverPath">Caminho de Servidor:</td>
            <td class="PropValue"><xsl:value-of select="Item/@item"/></td>
        </tr>
        <tr>
            <td class="PropName" _locID="changeset">Changeset:</td>
            <td class="PropValue">
            <xsl:if test="string-length(Item/@csurl) > 0">
                <xsl:call-template name="link">
                    <xsl:with-param name="format" select="'html'"/>
                    <xsl:with-param name="link" select="Item/@csurl"/>
                    <xsl:with-param name="displayText" select="Item/@cs"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="string-length(Item/@csurl) = 0">
                <xsl:value-of select="Item/@cs"/>
            </xsl:if>
            </td>
        </tr>
        <tr>
            <td class="PropName" _locID="lastModifiedOn">Modificado por Último em:</td>
            <td class="PropValue"><xsl:value-of select="Item/@date"/></td>
        </tr>
        <tr>
            <td class="PropName" _locID="typeWithColon">Tipo:</td>
            <td class="PropValue">
                <xsl:if test="Item/@type = 'File'">
                    <xsl:value-of select="$FileType"/>
                </xsl:if>
                <xsl:if test="Item/@type = 'Folder'">
                    <xsl:value-of select="$FolderType"/>
                </xsl:if>
            </td>
        </tr>
        <xsl:if test="Item/@type = 'File'">
        <tr>
            <td class="PropName" _locID="fileSizeInBytes">Tamanho do Arquivo (bytes):</td>
            <td class="PropValue"><xsl:value-of select="Item/@len"/></td>
        </tr>
        </xsl:if>
    </table>
    </xsl:when>
    <xsl:when test="$format='text'">
<xsl:if test="string-length(Item/@title) > 0">
<xsl:value-of select="Item/@title"/>
</xsl:if>
<xsl:if test="string-length(Item/@title) = 0">
<xsl:value-of select="Item/@item"/>
</xsl:if>

<xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="summary"-->Sumário</xsl:text>
<xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="serverPath"-->Caminho de Servidor:</xsl:text>       <xsl:value-of select="Item/@item"/>
<xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="changeset"-->Changeset:</xsl:text>         <xsl:if test="string-length(Item/@csurl) > 0">
<xsl:call-template name="link">
<xsl:with-param name="format" select="'text'"/>
<xsl:with-param name="link" select="Item/@csurl"/>
<xsl:with-param name="displayText" select="Item/@cs"/>
</xsl:call-template>
</xsl:if>
<xsl:if test="string-length(Item/@csurl) = 0">
<xsl:value-of select="Item/@cs"/>
</xsl:if>
  <xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="lastModifiedOn"-->Modificado por Último em:</xsl:text>  <xsl:value-of select="Item/@date"/>
<xsl:if test="Item/@type = 'File'">
  <xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="typeWithColon"-->Tipo:</xsl:text>              <xsl:value-of select="$FileType"/>
</xsl:if>
<xsl:if test="Item/@type = 'Folder'">
  <xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="typeWithColon"-->Tipo:</xsl:text>              <xsl:value-of select="$FolderType"/>
</xsl:if>
<xsl:if test="@type = 'File'">
  <xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="fileSizeInBytes"-->Tamanho do Arquivo (bytes):</xsl:text> <xsl:value-of select="Item/@len"/>
</xsl:if>
</xsl:when>
</xsl:choose>
<xsl:call-template name="footer">
   <xsl:with-param name="format" select="$format"/>
   <xsl:with-param name="timeZoneOffset" select="Item/@tzo"/>
   <xsl:with-param name="timeZoneName" select="Item/@tz"/>
</xsl:call-template>
</xsl:template>

<!-- Shelved Item -->
<xsl:template name="TeamFoundationShelvedItem">
<xsl:param name="format"/>
<xsl:param name="PendingChange"/>
<xsl:choose>
    <xsl:when test="$format='html'">
    <xsl:if test="string-length(PendingChange/@title) > 0">
        <title><xsl:value-of select="PendingChange/@title"/></title>
        <div class="Title"><xsl:value-of select="PendingChange/@title"/></div>
    </xsl:if>
    <xsl:if test="string-length(PendingChange/@title) = 0">
        <title><xsl:value-of select="PendingChange/@item"/></title>
        <div class="Title"><xsl:value-of select="PendingChange/@item"/></div>
    </xsl:if>
    <b _locID="summary">Sumário</b>
    <table>
        <tr>
            <td class="PropName" _locID="serverPath">Caminho de Servidor:</td>
            <td class="PropValue"><xsl:value-of select="PendingChange/@item"/></td>
        </tr>
        <xsl:if test="string-length(PendingChange/@srcitem) > 0">
            <tr>
                <td class="PropName" _locID="sourceServerPath">Caminho de Origem no Servidor:</td>
                <td class="PropValue"><xsl:value-of select="PendingChange/@srcitem"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="string-length(PendingChange/@ssurl) > 0">
            <tr>
                <td class="PropName" _locID="shelveset">Shelveset:</td>
                <td class="PropValue">
                <xsl:call-template name="link">
                    <xsl:with-param name="format" select="'html'"/>
                    <xsl:with-param name="link" select="PendingChange/@ssurl"/>
                    <xsl:with-param name="displayText" select="PendingChange/@ss"/>
                </xsl:call-template>
                </td>
            </tr>
        </xsl:if>
        <tr>
            <td class="PropName" _locID="creationDate">Data de Criação:</td>
            <td class="PropValue"><xsl:value-of select="PendingChange/@date"/></td>
        </tr>
        <tr>
            <td class="PropName" _locID="typeWithColon">Tipo:</td>
            <td class="PropValue">
                <xsl:if test="PendingChange/@type = 'File'">
                    <xsl:value-of select="$FileType"/>
                </xsl:if>
                <xsl:if test="PendingChange/@type = 'Folder'">
                    <xsl:value-of select="$FolderType"/>
                </xsl:if>
            </td>
        </tr>
        <xsl:if test="string-length(PendingChange/@ssurl) > 0"><!-- @chg is only localized in webView -->
            <tr>
                <td class="PropName" _locID="changeWithColon">Mudança:</td>
                <td class="PropValue"><xsl:value-of select="PendingChange/@chg"/></td>
            </tr>
        </xsl:if>
    </table>
    </xsl:when>
    <xsl:when test="$format='text'">
<xsl:if test="string-length(PendingChange/@title) > 0">
<xsl:value-of select="PendingChange/@title"/>
</xsl:if>
<xsl:if test="string-length(PendingChange/@title) = 0">
<xsl:value-of select="PendingChange/@item"/>
</xsl:if>

<xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="summary"-->Sumário</xsl:text>
<xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="serverPath"-->Caminho de Servidor:</xsl:text>       <xsl:value-of select="PendingChange/@item"/>
<xsl:if test="string-length(PendingChange/@srcitem) > 0">
<xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="sourceServerPath"-->Caminho de Origem do Servidor:</xsl:text>       <xsl:value-of select="PendingChange/@srcitem"/>
</xsl:if>
<xsl:if test="string-length(PendingChange/@ssurl) >0">
<xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="shelveset"-->Shelveset:</xsl:text>
<xsl:call-template name="link">
<xsl:with-param name="format" select="'text'"/>
<xsl:with-param name="link" select="PendingChange/@ssurl"/>
<xsl:with-param name="displayText" select="PendingChange/@ss"/>
</xsl:call-template>
</xsl:if>
  <xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="createdOn"-->Criado em:</xsl:text>  <xsl:value-of select="PendingChange/@date"/>
<xsl:if test="PendingChange/@type = 'File'">
  <xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="typeWithColon"-->Tipo:</xsl:text>              <xsl:value-of select="$FileType"/>
</xsl:if>
<xsl:if test="PendingChange/@type = 'Folder'">
  <xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="typeWithColon"-->Tipo:</xsl:text>              <xsl:value-of select="$FolderType"/>
</xsl:if>
<xsl:if test="string-length(PendingChange/@ssurl) > 0">
<xsl:text>&#xA;</xsl:text><xsl:text><!--_locID_text="changeWithColon"-->Mudança:</xsl:text>              <xsl:value-of select="PendingChange/@chg"/>
</xsl:if>
</xsl:when>
</xsl:choose>
<xsl:call-template name="footer">
   <xsl:with-param name="format" select="$format"/>
</xsl:call-template>
</xsl:template>

<!-- Checkin event -->
<xsl:template name="CheckinEvent">
<xsl:param name="CheckinEvent"/>
<head>
    <title><xsl:value-of select="Title"/></title>
<div class="Title">
<xsl:call-template name="link">
  <xsl:with-param name="format" select="'html'"/>
  <xsl:with-param name="embolden" select="'true'"/>
  <xsl:with-param name="fontSize" select="'larger'"/>
  <xsl:with-param name="link" select="Artifacts/Artifact[@ArtifactType='Changeset']/Url"/>
  <xsl:with-param name="displayText" select="ContentTitle"/>
</xsl:call-template>
<!-- Pull in the command style settings -->
<xsl:call-template name="style">
</xsl:call-template>
</div>
</head>
<body lang="EN-US" link="blue" vlink="purple">
<!-- Display the summary message -->
<xsl:if test="string-length(Notice) > 0">
    <br/>
    <h1>
    <xsl:value-of select="Notice"/>
    </h1>
</xsl:if>
<br/>
<b _locID="summary">Sumário</b>
<table style="table-layout: fixed">
<tr>
<td _locID="teamProjects" class="PropName">Team Project(s):</td>
<td class="PropValue">
    <xsl:value-of select="TeamProject"/>
</td>
</tr>
<tr>
<xsl:choose>
    <xsl:when test="Owner != Committer">
        <td _locID="checkedInOnBehalfOf" class="PropName">Check-in realizado em nome de:</td>
    </xsl:when>
    <xsl:when test="Owner = Committer">
        <td _locID="checkedInBy" class="PropName">Check-in realizado por:</td>
    </xsl:when>
</xsl:choose>
<td class="PropValue">
    <xsl:variable name="owner" select="OwnerDisplay"/>
    <xsl:if test="$owner=''">
        <xsl:value-of select="OwnerDisplay"/>
    </xsl:if>
    <xsl:if test="$owner!=''">
        <xsl:value-of select="$owner"/>
    </xsl:if>
</td>
</tr>
<xsl:if test="string-length(Committer) > 0">
    <!-- only print if commiter != owner ) -->
    <xsl:if test="Owner != Committer">
    <tr>
        <td _locID="checkedInBy" class="PropName">Check-in realizado por:</td>
        <td class="PropValue">
        <xsl:variable name="cmtr" select="CommitterDisplay"/>
        <xsl:if test="$cmtr=''">
            <xsl:value-of select="CommitterDisplay"/>
        </xsl:if>
        <xsl:if test="$cmtr!=''">
            <xsl:value-of select="$cmtr"/>
        </xsl:if>
        </td>
    </tr>
    </xsl:if>
</xsl:if>
<tr>
<td _locID="checkedInOn" class="PropName">Check-in realizado em:</td>
<td class="PropValue">
  <xsl:value-of select="CreationDate"/>
</td>
</tr>
<!-- Add the checkin notes, if present -->
<xsl:for-each select="CheckinNotes/CheckinNote">
<tr>
  <td class="PropName"><xsl:value-of select="concat(@name,':')"/></td>
  <td class="PropValue">
    <xsl:variable name="valueLength" select="string-length(@val)"/>
    <xsl:if test="$valueLength > 0"><pre><xsl:value-of select="@val"/></pre></xsl:if>
    <xsl:if test="$valueLength = 0"><pre _locID="none">Nenhum</pre></xsl:if>
  </td>
</tr>
</xsl:for-each>
<tr>
<td _locID="comment" class="PropName">Comentários:</td>
<td class="PropValue">
  <xsl:variable name="commentLength" select="string-length(Comment)"/>
  <xsl:if test="$commentLength > 0">
    <pre>
        <xsl:value-of select="Comment"/>
    </pre>
  </xsl:if>
  <xsl:if test="$commentLength = 0"><pre _locID="none">Nenhum</pre></xsl:if>
</td>
  </tr>
<!-- Optional policy override comment -->
<xsl:if test="string-length(PolicyOverrideComment) > 0">
 <tr>
 <td _locID="policyOverrideReason" class="PropName">Razão para Ignorar Política:</td>
<td class="PropValue">
    <pre><xsl:value-of select="PolicyOverrideComment"/></pre>
</td>
 </tr>
</xsl:if>
</table>
<!-- Add the work item information, if present -->
<xsl:if test="count(CheckinInformation/CheckinInformation[@CheckinAction='Resolve']) > 0">
<br/>
<b _locID="resolvedWorkItems">Work Items Resolvidos</b>
<table class="WithBorder">
<tr>
  <td class="ColHeadingSmall" _locID="type">Tipo</td>
  <td class="ColHeadingXSmall" _locID="id">ID</td>
  <td class="ColHeading" _locID="title">Tíitulo</td>
  <td class="ColHeadingSmall" _locID="status">Status</td>
  <td class="ColHeadingSmall" _locID="assignedTo">Atribuído à</td>
</tr>
<xsl:for-each select="CheckinInformation/CheckinInformation[@CheckinAction='Resolve']">
<xsl:sort select="@Type"/>
<xsl:sort select="@Id" data-type="number" />
  <tr>
      <xsl:call-template name="wiItem">
          <xsl:with-param name="Url" select="@Url"/>
          <xsl:with-param name="Type" select="@Type"/>
          <xsl:with-param name="Id" select="@Id"/>
          <xsl:with-param name="Title" select="@Title"/>
          <xsl:with-param name="State" select="@State"/>
          <xsl:with-param name="AssignedTo" select="@AssignedTo"/>
      </xsl:call-template>
  </tr>
</xsl:for-each>
</table>
</xsl:if> <!-- Resolved WI Info -->
<!-- Add the Associated work item information, if present -->
<xsl:if test="count(CheckinInformation/CheckinInformation[@CheckinAction='Associate']) > 0">
<br/>
<b _locID="associatedWorkItems">Work Items Associados</b>
<table class="WithBorder">
<tr>
  <td class="ColHeadingSmall" _locID="type">Tipo</td>
  <td class="ColHeadingXSmall" _locID="id">ID</td>
  <td class="ColHeading" _locID="title">Título</td>
  <td class="ColHeadingSmall" _locID="status">Status</td>
  <td class="ColHeadingSmall" _locID="assignedTo">Atribuído à</td>
</tr>
<xsl:for-each select="CheckinInformation/CheckinInformation[@CheckinAction='Associate']">
<xsl:sort select="@Type"/>
<xsl:sort select="@Id" data-type="number" />
  <tr>
      <xsl:call-template name="wiItem">
          <xsl:with-param name="Url" select="@Url"/>
          <xsl:with-param name="Type" select="@Type"/>
          <xsl:with-param name="Id" select="@Id"/>
          <xsl:with-param name="Title" select="@Title"/>
          <xsl:with-param name="State" select="@State"/>
          <xsl:with-param name="AssignedTo" select="@AssignedTo"/>
      </xsl:call-template>
  </tr>
</xsl:for-each>
</table>
</xsl:if> <!-- Associated WI Info -->
<!-- Add policy failures, if present -->
<xsl:if test="count(PolicyFailures/PolicyFailure) > 0">
<br/>
<b _locId="policyFailures">Erros de Política</b>
<table class="WithBorder">
<tr>
  <td class="ColHeading" _locID="type">Tipo</td>
  <td class="ColHeading" _locID="description">Descrição</td>
</tr>
<xsl:for-each select="PolicyFailures/PolicyFailure">
  <tr>
    <td class="ColData">
      <xsl:value-of select="@name"/>
  </td>
    <td class="ColData">
      <xsl:variable name="valueLength" select="string-length(@val)"/>
      <xsl:if test="$valueLength > 0"><xsl:value-of select="@val"/></xsl:if>
      <xsl:if test="$valueLength = 0"><pre _locID="none">Nenhum</pre></xsl:if>
    </td>
  </tr>
</xsl:for-each>
</table>
</xsl:if>
<!-- Add the versioned items -->
<xsl:if test="count(Artifacts/Artifact[@ArtifactType='VersionedItem']) > 0">
<br/>
<b _locID="items">Itens</b>
<table class="WithBorder">
<tr>
<td class="ColHeading" _locID="name">Nome</td>
<td class="ColHeadingSmall" _locID="change">Mudança</td>
<td class="ColHeading" _locID="folder">Pasta</td>
</tr>
<xsl:for-each select="Artifacts/Artifact[@ArtifactType='VersionedItem']">
<tr>
  <td class="ColData">
      <xsl:call-template name="link">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="link" select="Url"/>
        <xsl:with-param name="displayText" select="@Item"/>
      </xsl:call-template>
  </td> 
  <td class="ColDataSmall"><xsl:value-of select="@ChangeType"/></td>
  <td class="ColData"><xsl:value-of select="@Folder"/></td>
</tr>
</xsl:for-each>
<xsl:if test="AllChangesIncluded = 'false'">
<tr>
  <td class="ColData">
      <xsl:call-template name="link">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="link" select="Artifacts/Artifact[@ArtifactType='Changeset']/Url"/>
        <xsl:with-param name="displayText" select="$morePrompt"/>
      </xsl:call-template>
  </td> 
  <td class="ColDataSmall"><xsl:value-of select="' '"/></td>
  <td class="ColData"><xsl:value-of select="' '"/></td>
</tr>
</xsl:if>
</table>
</xsl:if> <!-- if there are versioned items -->
<xsl:call-template name="footer">
<xsl:with-param name="format" select="'html'"/>
<xsl:with-param name="alertOwner" select="Subscriber"/>
<xsl:with-param name="timeZoneOffset" select="TimeZoneOffset"/>
<xsl:with-param name="timeZoneName" select="TimeZone"/>
</xsl:call-template>
</body>

</xsl:template> <!-- checkin event -->

<!-- Shelveset event -->
<xsl:template name="ShelvesetEvent">
<xsl:param name="ShelvesetEvent"/>
<head>
    <title><xsl:value-of select="Title"/></title>
<div class="Title">
<xsl:call-template name="link">
  <xsl:with-param name="format" select="'html'"/>
  <xsl:with-param name="embolden" select="'true'"/>
  <xsl:with-param name="fontSize" select="'larger'"/>
  <xsl:with-param name="link" select="Artifacts/Artifact[@ArtifactType='Shelveset']/Url"/>
  <xsl:with-param name="displayText" select="ContentTitle"/>
</xsl:call-template>
<!-- Pull in the command style settings -->
<xsl:call-template name="style">
</xsl:call-template>
</div>
</head>
<body lang="EN-US" link="blue" vlink="purple">
<!-- Display the summary message -->
<xsl:if test="string-length(Notice) > 0">
    <br/>
    <h1>
    <xsl:value-of select="Notice"/>
    </h1>
</xsl:if>
<br/>
<b _locID="summary">Sumário</b>
<table style="table-layout: fixed">
<tr>
<td _locID="teamProjects" class="PropName">Team Project(s):</td>
<td class="PropValue">
    <xsl:value-of select="TeamProject"/>
</td>
</tr>
<tr>
<td _locID="owner" class="PropName">Dono:</td>
<td class="PropValue">
    <xsl:variable name="owner" select="OwnerDisplay"/>
    <xsl:if test="$owner=''">
        <xsl:value-of select="OwnerDisplay"/>
    </xsl:if>
    <xsl:if test="$owner!=''">
        <xsl:value-of select="$owner"/>
    </xsl:if>
</td>
</tr>
<tr>
<td _locID="createdOn" class="PropName">Criado em:</td>
<td class="PropValue">
  <xsl:value-of select="CreationDate"/>
</td>
</tr>
<!-- Add the checkin notes, if present -->
<xsl:for-each select="CheckinNotes/CheckinNote">
<tr>
  <td class="PropName"><xsl:value-of select="concat(@name,':')"/></td>
  <td class="PropValue">
    <xsl:variable name="valueLength" select="string-length(@val)"/>
    <xsl:if test="$valueLength > 0"><pre><xsl:value-of select="@val"/></pre></xsl:if>
    <xsl:if test="$valueLength = 0"><pre _locID="none">Nenhum</pre></xsl:if>
  </td>
</tr>
</xsl:for-each>
<tr>
<td _locID="comment" class="PropName">Comentários:</td>
<td class="PropValue">
  <xsl:variable name="commentLength" select="string-length(Comment)"/>
  <xsl:if test="$commentLength > 0">
    <pre>
        <xsl:value-of select="Comment"/>
    </pre>
  </xsl:if>
  <xsl:if test="$commentLength = 0"><pre _locID="none">Nenhum</pre></xsl:if>
</td>
  </tr>
<!-- Optional policy override comment -->
<xsl:if test="string-length(PolicyOverrideComment) > 0">
 <tr>
 <td _locID="policyOverrideReason" class="PropName">Razão para Ignorar Política:</td>
<td class="PropValue">
    <pre><xsl:value-of select="PolicyOverrideComment"/></pre>
</td>
 </tr>
</xsl:if>
</table>
<!-- Add the work item information, if present -->
<xsl:if test="count(CheckinInformation/CheckinInformation) > 0">
<br/>
<b _locID="WorkItems">Work Items</b>
<table class="WithBorder">
<tr>
  <td class="ColHeadingSmall" _locID="type">Tipo</td>
  <td class="ColHeadingXSmall" _locID="id">ID</td>
  <td class="ColHeading" _locID="title">Título</td>
  <td class="ColHeadingSmall" _locID="action">Ação</td>
  <td class="ColHeadingSmall" _locID="assignedTo">Atriibuído à</td>
</tr>
<xsl:for-each select="CheckinInformation/CheckinInformation">
<xsl:sort select="@Type"/>
<xsl:sort select="@Id" data-type="number" />
  <tr>
      <xsl:call-template name="wiItem">
          <xsl:with-param name="Url" select="@Url"/>
          <xsl:with-param name="Type" select="@Type"/>
          <xsl:with-param name="Id" select="@Id"/>
          <xsl:with-param name="Title" select="@Title"/>
          <xsl:with-param name="State">
             <xsl:if test="@CheckinAction='Resolve'"><xsl:value-of select="$CheckinActionResolve"/></xsl:if>
             <xsl:if test="@CheckinAction!='Resolve'"><xsl:value-of select="$CheckinActionAssociate"/></xsl:if>
          </xsl:with-param>
          <xsl:with-param name="AssignedTo" select="@AssignedTo"/>
      </xsl:call-template>
  </tr>
</xsl:for-each>
</table>
</xsl:if> <!-- WI Info -->
<!-- Add the Shelved items -->
<xsl:if test="count(Artifacts/Artifact[@ArtifactType='ShelvedItem']) > 0">
<br/>
<b _locID="shelvedChanges">Mudanças no Shelve</b>
<table class="WithBorder">
<tr>
<td class="ColHeading" _locID="name">Nome</td>
<td class="ColHeadingSmall" _locID="change">Mudança</td>
<td class="ColHeading" _locID="folder">Pasta</td>
</tr>
<xsl:for-each select="Artifacts/Artifact[@ArtifactType='ShelvedItem']">
<tr>
  <td class="ColData">
      <xsl:call-template name="link">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="link" select="Url"/>
        <xsl:with-param name="displayText" select="@Item"/>
      </xsl:call-template>
  </td> 
  <td class="ColDataSmall"><xsl:value-of select="@ChangeType"/></td>
  <td class="ColData"><xsl:value-of select="@Folder"/></td>
</tr>
</xsl:for-each>
<xsl:if test="AllChangesIncluded = 'false'">
<tr>
  <td class="ColData">
      <xsl:call-template name="link">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="link" select="Artifacts/Artifact[@ArtifactType='Shelveset']/Url"/>
        <xsl:with-param name="displayText" select="$morePrompt"/>
      </xsl:call-template>
  </td> 
  <td class="ColDataSmall"><xsl:value-of select="' '"/></td>
  <td class="ColData"><xsl:value-of select="' '"/></td>
</tr>
</xsl:if>
</table>
</xsl:if> <!-- if there are shelved items -->
<xsl:call-template name="footer">
<xsl:with-param name="format" select="'html'"/>
<xsl:with-param name="alertOwner" select="Subscriber"/>
<xsl:with-param name="timeZoneOffset" select="TimeZoneOffset"/>
<xsl:with-param name="timeZoneName" select="TimeZone"/>
</xsl:call-template>
</body>

</xsl:template> <!-- shelveset event -->

<!-- Workitem (Source Code Control View) -->
<xsl:template name="wiItem">
    <xsl:param name="Url"/>
    <xsl:param name="Type"/>
    <xsl:param name="Id"/>
    <xsl:param name="Title"/>
    <xsl:param name="State"/>
    <xsl:param name="AssignedTo"/>
    <td class="ColDataSmall"><xsl:value-of select="@Type"/></td>
    <td class="ColDataXSmall" >
      <xsl:call-template name="link">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="link" select="@Url"/>
        <xsl:with-param name="displayText" select="@Id"/>
      </xsl:call-template>
    </td> 
    <td class="ColData"><xsl:value-of select="@Title"/></td>
    <td class="ColDataSmall"><xsl:value-of select="$State"/></td>
    <td class="ColDataSmall">
      <xsl:variable name="assignedToLength" select="string-length(@AssignedTo)"/>
      <xsl:if test="$assignedToLength > 0"><xsl:value-of select="@AssignedTo"/></xsl:if>
      <xsl:if test="$assignedToLength = 0"><!--_locID_text="notAvailable-->N/A</xsl:if>
    </td>
</xsl:template> <!-- wiItem -->

<!-- Handle exceptions -->
<xsl:template name="Exception">
    <xsl:param name="format"/>
    <xsl:param name="Exception"/>
    <xsl:if test="$format='html'">
        <div class="Title">
        <xsl:value-of select="$Error"/>
        </div>
        <br/>
        <xsl:value-of select="$DetailedErrorHeader"/>
        <br/>
        <pre><xsl:value-of select="$Exception/Message"/></pre>
        <xsl:call-template name="footer">
          <xsl:with-param name="format" select="'html'"/>
        </xsl:call-template>
    </xsl:if>
    <xsl:if test="$format='text'">
    <xsl:value-of select="$Error"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="$DetailedErrorHeader"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="$Exception/Message"/>
    </xsl:if>
</xsl:template>


</xsl:stylesheet>
