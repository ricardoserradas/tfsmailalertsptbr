<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://schemas.microsoft.com/TeamFoundation/2010/Build">
  <xsl:import href="TeamFoundation.xsl"/>
  <!-- Common TeamSystem elements -->
  <xsl:template match="BuildResourceChangedEvent">
    <head>
      <title>
        <xsl:value-of select="Title" />
      </title>
      <!-- Pull in the common style settings -->
      <xsl:call-template name="style" />
      <div class="Title">
        <xsl:value-of select="Title" />
      </div>
      <br/>
    </head>
    <body>
        <table>
            <tr>
                <td class="PropName" _locID="TeamProjectCollection">Team Project Collection: </td>
                <td class="PropValue">
                    <xsl:value-of select="@TeamProjectCollectionUrl"/>
                </td>
            </tr>
            <tr>
                <td class="PropName" _locID="EventAction">Ação: </td>
                <td class="PropValue">
                    <b>
                        <xsl:value-of select="@ChangedType"/>
                    </b>
                </td>
            </tr>
            <tr>
                <td class="PropName" _locID="ResourceType">Tipo de Recurso: </td>
                <td class="PropValue">
                    <b>
                        <xsl:value-of select="@ResourceType"/>
                    </b>
                </td>
            </tr>
            <tr>
                <td class="PropName" _locID="Name">Nome: </td>
                <td class="PropValue">
                    <xsl:value-of select="@Name"/> (<xsl:value-of select="@Uri" />)
                </td>
            </tr>
            <tr>
                <td class="PropName" _locID="ChangedBy">Modificado por: </td>
                <td class="PropValue">
                    <xsl:value-of select="@ChangedBy"/>
                </td>
            </tr>
            <br/>
            <xsl:choose>
                <xsl:when test="@ChangedType = 'Added'">
                    <xsl:for-each select="PropertyChanges/PropertyChange">
                        <xsl:sort select="@Name"/>
                        <tr>
                            <td class="PropName">
                                <xsl:value-of select="@Name" />:
                            </td>
                            <td class="PropValue">
                                <xsl:value-of select="b:NewValue" />
                            </td>
                        </tr>
                    </xsl:for-each>
                </xsl:when>

                <xsl:when test="@ChangedType = 'Updated'">
                    <xsl:for-each select="PropertyChanges/PropertyChange">
                        <xsl:sort select="@Name"/>
                        <tr>
                            <td class="PropName">
                                <b>
                                    <xsl:value-of select="@Name" />
                                </b>:
                            </td>
                        </tr>
                        <tr>
                            <td class="PropName">&#160;&#160;&#160;&#160;Valor Anterior:</td>
                            <td class="PropValue">
                                <xsl:value-of select="b:OldValue" />
                            </td>
                        </tr>
                        <tr>
                            <td class="PropName">&#160;&#160;&#160;&#160;Novo Valor:</td>
                            <td class="PropValue">
                                <xsl:value-of select="b:NewValue" />
                            </td>
                        </tr>
                    </xsl:for-each>
                </xsl:when>

                <xsl:when test="@ChangedType = 'Deleted'">
                    <xsl:for-each select="PropertyChanges/PropertyChange">
                        <xsl:sort select="@Name"/>
                        <tr>
                            <td class="PropName">
                                <xsl:value-of select="@Name" />:
                            </td>
                            <td class="PropValue">
                                <xsl:value-of select="b:OldValue" />
                            </td>
                        </tr>
                    </xsl:for-each>
                </xsl:when>
            </xsl:choose>
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