<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="TeamFoundation.xsl"/>
  <!-- Common TFS elements -->
  <xsl:template match="ConfirmPreferredEmailEvent">
    <head>
      <title _locID="Title">[Team Foundation Service] Confirm new preferred email address</title>
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
    </head>
    <body>
      <div style="font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; font-size: 12pt;">
        <div>Hi <xsl:value-of select="DisplayNameText"/>,</div>
        <br/>
        <div>It looks like you updated the preferred email address of your Microsoft Visual Studio profile.</div>
        <br/>
        <div>Once you <a><xsl:attribute name="HREF"><xsl:value-of select="ConfirmationUrl"/></xsl:attribute>click to confirm</a>, we will use <b><xsl:value-of select="NewEmailAddress"/></b> for future communications like alerts and service notifications.</div>
        <br/>
        <div>If you did not make this change, please contact us at TFServiceSupport@microsoft.com so we can investigate.</div>
        <br/>
        <div>Thank you,</div>
        <div>The Visual Studio team</div>
        <br/>
        <div>Microsoft respects your privacy. Please read our online <a href="http://go.microsoft.com/fwlink/?LinkID=246330">Privacy Statement</a>.</div>
      </div>
    </body>
  </xsl:template>
</xsl:stylesheet>
