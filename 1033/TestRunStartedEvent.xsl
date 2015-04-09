<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="TeamFoundation.xsl"/>
  <!-- Common TeamSystem elements -->
  <xsl:template match="TestRunStartedEvent">
    <head>
      <title _locID="Title">Execução de Testes Iniciada</title>
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
          <td class="PropName" _locID="TestPlanId">Id do Plano de Testes: </td>
          <td class="PropValue">
            <xsl:value-of select="TestPlanId"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="IsAutomated">É Automatizado? </td>
          <td class="PropValue">
            <xsl:value-of select="IsAutomated"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="CreationDate">Data da Criação: </td>
          <td class="PropValue">
            <xsl:value-of select="CreationDate"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="Owner">Dono: </td>
          <td class="PropValue">
            <xsl:value-of select="Owner"/>
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="State">Estado: </td>
          <td class="PropValue">
            <xsl:value-of select="State"/>
          </td>
        </tr>
        <xsl:if test="BuildNumber != ''">
          <tr>
            <td class="PropName" _locID="BuildNumber">Id do Build: </td>
            <td class="PropValue">
              <xsl:value-of select="BuildNumber" />
            </td>
          </tr>        
        </xsl:if>
        <tr>
          <td class="PropName" _locID="TotalTests">Testes Totais: </td>
          <td class="PropValue">
            <xsl:value-of select="TotalTests" />
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="LastUpdated">Data da Última Modificação: </td>
          <td class="PropValue">
            <xsl:value-of select="LastUpdated" />
          </td>
        </tr>
        <tr>
          <td class="PropName" _locID="LastUpdatedBy">Atualizado por último por: </td>
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
