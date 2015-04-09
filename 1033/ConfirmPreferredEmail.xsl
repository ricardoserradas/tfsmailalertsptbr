<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="TeamFoundation.xsl"/>
  <!-- Common TFS elements -->
  <xsl:template match="ConfirmPreferredEmailEvent">
    <head>
      <title _locID="Title">[Team Foundation Service] Confirme o novo endereço de e-mail preferencial</title>
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
        <div>Olá <xsl:value-of select="DisplayNameText"/>,</div>
        <br/>
        <div>Parece que você atualizou seu endereço de e-mail preferencial no seu perfil do Microsoft Visual Studio.</div>
        <br/>
        <div>Uma vez que vocë <a><xsl:attribute name="HREF"><xsl:value-of select="ConfirmationUrl"/></xsl:attribute>clicar em confirmar</a>, nós vamos usar <b><xsl:value-of select="NewEmailAddress"/></b> para comunicações futuras, como alertas e notificações de serviços.</div>
        <br/>
        <div>Se você não realizou esta mudança, por favor entre em contato conosco através do e-mail TFServiceSupport@microsoft.com para que possamos investigar.</div>
        <br/>
        <div>Obrigado,</div>
        <div>O Time de Visual Studio</div>
        <br/>
        <div>A Microsoft respeita sua privacidade. Por favor leia nossa <a href="http://go.microsoft.com/fwlink/?LinkID=246330">Política de Privacidade</a> online.</div>
      </div>
    </body>
  </xsl:template>
</xsl:stylesheet>
