<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:import href="TeamFoundation.xsl"/>
  <!-- Common TeamSystem elements -->
  <xsl:template match="WorkItemChangedEvent">
    <head>
      <!-- Pull in the command style settings -->
      <xsl:call-template name="style">
      </xsl:call-template>
    </head>
    <body>
      <div class="Title">
        <b>
          <xsl:choose>
            <xsl:when test="DisplayUrl[.!='']">
              <xsl:element name="a">
                <xsl:attribute name="href">
                  <xsl:value-of select="DisplayUrl" />
                </xsl:attribute>
                <!-- _locID_text="WorkItemText1"-->Work item
                <xsl:if test="ChangeType[.='New']">
                  <!-- _locID_text="CreatedColon1"-->Criado:
                </xsl:if>
                <xsl:if test="ChangeType[.='Change']">
                  <!-- _locID_text="ChangedColon1"-->Modificado:
                </xsl:if>
                <xsl:for-each select="CoreFields/StringFields/Field">
                  <xsl:if test="ReferenceName[.='System.WorkItemType']">
                    <xsl:value-of select="NewValue"/>
                  </xsl:if>
                </xsl:for-each>
                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                <xsl:for-each select="CoreFields/IntegerFields/Field">
                  <xsl:if test="ReferenceName[.='System.Id']">
                    <xsl:value-of select="NewValue"/>
                  </xsl:if>
                </xsl:for-each>
                -
                <xsl:value-of select="WorkItemTitle" />
              </xsl:element>
            </xsl:when>
            <xsl:otherwise>
              <!-- _locID_text="WorkItemText2" -->Work item
              <xsl:if test="ChangeType[.='New']">
                <!-- _locID_text="CreatedColon2"-->Criado:
              </xsl:if>
              <xsl:if test="ChangeType[.='Change']">
                <!-- _locID_text="ChangedColon2"-->Modificado:
              </xsl:if>
              <xsl:for-each select="CoreFields/StringFields/Field">
                <xsl:if test="ReferenceName[.='System.WorkItemType']">
                  <xsl:value-of select="NewValue"/>
                </xsl:if>
              </xsl:for-each>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <xsl:for-each select="CoreFields/IntegerFields/Field">
                <xsl:if test="ReferenceName[.='System.Id']">
                  <xsl:value-of select="NewValue"/>
                </xsl:if>
              </xsl:for-each>
              -
              <xsl:value-of select="WorkItemTitle" />
            </xsl:otherwise>
          </xsl:choose>
        </b>
      </div>
      <br />
      <table>
        <tr>
          <td class="PropName">
            <!-- _locID_text="TeamProjectColon" -->Team project:
          </td>
          <td class="PropValue">
            <xsl:value-of select="PortfolioProject" />
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="AreaColon" -->Área:
          </td>
          <td class="PropValue">
            <xsl:value-of select="AreaPath" />
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="IterationColon" -->Iteração:
          </td>
          <td class="PropValue">
            <xsl:for-each select="CoreFields/StringFields/Field">
              <xsl:if test="ReferenceName[.='System.IterationPath']">
                <xsl:value-of select="NewValue"/>
              </xsl:if>
            </xsl:for-each>
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="AssignedToColon" -->Atribuído à:
          </td>
          <td class="PropValue">
            <xsl:for-each select="CoreFields/StringFields/Field">
              <xsl:if test="ReferenceName[.='System.AssignedTo']">
                <xsl:value-of select="NewValue"/>
              </xsl:if>
            </xsl:for-each>
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="StateColon" -->Estado:
          </td>
          <td class="PropValue">
            <xsl:for-each select="CoreFields/StringFields/Field">
              <xsl:if test="ReferenceName[.='System.State']">
                <xsl:value-of select="NewValue"/>
              </xsl:if>
            </xsl:for-each>
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="ReasonColon" -->Razão:
          </td>
          <td class="PropValue">
            <xsl:for-each select="CoreFields/StringFields/Field">
              <xsl:if test="ReferenceName[.='System.Reason']">
                <xsl:value-of select="NewValue"/>
              </xsl:if>
            </xsl:for-each>
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="ChangedByColon" -->Modificado por:
          </td>
          <td class="PropValue">
            <xsl:for-each select="CoreFields/StringFields/Field">
              <xsl:if test="ReferenceName[.='System.ChangedBy']">
                <xsl:value-of select="NewValue"/>
              </xsl:if>
            </xsl:for-each>
          </td>
        </tr>
        <tr>
          <td class="PropName">
            <!-- _locID_text="ChangedDateColon" -->Data da Modificação:
          </td>
          <td class="PropValue">
            <xsl:for-each select="CoreFields/StringFields/Field">
              <xsl:if test="ReferenceName[.='System.ChangedDate']">
                <xsl:value-of select="NewValue"/>
              </xsl:if>
            </xsl:for-each>
          </td>
        </tr>
      </table>

      <br/>

      <xsl:if test="count(/WorkItemChangedEvent/ChangedFields//Field) > 0 or boolean(/WorkItemChangedEvent/TextFields/TextField)">
        <xsl:if test="ChangeType[.='New']" >
          <!-- _locID_text="OtherFields"-->Outros campos
        </xsl:if>
        <xsl:if test="ChangeType[.='Change']">
          <!-- _locID_text="ChangedFields"-->Campos modificados
        </xsl:if>
      </xsl:if>

      <xsl:if test="ChangeType[.='Change']">

        <xsl:if test="boolean(/WorkItemChangedEvent/TextFields/TextField)">
          <table class="WithBorder">
            <tr>
              <td class="ColHeadingMedium">
                <!-- _locID_text="FieldText1"-->Campo
              </td>
              <td class="ColHeading">
                <!-- _locID_text="NewValueText1"-->Novo Valor
              </td>
            </tr>

            <xsl:for-each select="TextFields/TextField">
              <xsl:if test="ReferenceName[.!='System.Tags']">
                <tr>
                  <td class="Col1Data">
                    <xsl:value-of select="Name"/>
                  </td>
                  <xsl:choose>
                    <xsl:when test="Value[.='']">
                      <td class="ColData">
                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                      </td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td class="ColData">
                        <xsl:value-of disable-output-escaping="yes" select="Value"/>
                      </td>
                    </xsl:otherwise>
                  </xsl:choose>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </table>
          <br/>
        </xsl:if>

        <xsl:if test="count(/WorkItemChangedEvent/ChangedFields//Field) > 0">
          <table class="WithBorder">
            <tr>
              <td class="ColHeadingMedium">
                <!-- _locID_text="FieldText2"-->Campo
              </td>
              <td class="ColHeading">
                <!-- _locID_text="NewValueText2"-->Novo Valor
              </td>
              <td class="ColHeading">
                <!-- _locID_text="OldValueText2"-->Valor Anterior
              </td>
            </tr>

            <xsl:for-each select="ChangedFields/IntegerFields/Field">
              <tr>
                <td class="Col1Data">
                  <xsl:value-of select="Name"/>
                </td>
                <xsl:choose>
                  <xsl:when test="NewValue[.='']">
                    <td class="ColData">
                      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                    </td>
                  </xsl:when>
                  <xsl:otherwise>
                    <td class="ColData">
                      <xsl:value-of select="NewValue"/>
                    </td>
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                  <xsl:when test="OldValue[.='']">
                    <td class="ColData">
                      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                    </td>
                  </xsl:when>
                  <xsl:otherwise>
                    <td class="ColData">
                      <xsl:value-of select="OldValue"/>
                    </td>
                  </xsl:otherwise>
                </xsl:choose>
              </tr>
            </xsl:for-each>
            <xsl:for-each select="ChangedFields/StringFields/Field">
              <xsl:if test="ReferenceName[.!='System.ChangedBy'] and ReferenceName[.!='System.ChangedDate']">
                <tr>
                  <td class="Col1Data">
                    <xsl:value-of select="Name"/>
                  </td>
                  <xsl:choose>
                    <xsl:when test="NewValue[.='']">
                      <td class="ColData">
                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                      </td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td class="ColData">
                        <xsl:value-of select="NewValue"/>
                      </td>
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                    <xsl:when test="OldValue[.='']">
                      <td class="ColData">
                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                      </td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td class="ColData">
                        <xsl:value-of select="OldValue"/>
                      </td>
                    </xsl:otherwise>
                  </xsl:choose>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </table>
        </xsl:if>
      </xsl:if>
      <!-- changetype = change -->

      <xsl:if test="ChangeType[.='New']">
        <xsl:if test="boolean(/WorkItemChangedEvent/TextFields/TextField) or count(/WorkItemChangedEvent/ChangedFields//Field) > 0">
          <table class="WithBorder">
            <tr>
              <td class="ColHeadingMedium">
                <!-- _locID_text="FieldText3"-->Campo
              </td>
              <td class="ColHeading" _locID="NewValue">
                <!-- _locID_text="NewValueText3"-->Novo Valor
              </td>
            </tr>

            <xsl:for-each select="TextFields/TextField">
              <xsl:if test="ReferenceName[.!='System.Tags']">
                <tr>
                  <td class="Col1Data">
                    <xsl:value-of select="Name"/>
                  </td>
                  <xsl:choose>
                    <xsl:when test="Value[.='']">
                      <td class="ColData">
                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                      </td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td class="ColData">
                        <xsl:value-of disable-output-escaping="yes" select="Value"/>
                      </td>
                    </xsl:otherwise>
                  </xsl:choose>
                </tr>
              </xsl:if>
            </xsl:for-each>

            <xsl:for-each select="ChangedFields/IntegerFields/Field">
              <tr>
                <td class="Col1Data">
                  <xsl:value-of select="Name"/>
                </td>
                <xsl:choose>
                  <xsl:when test="NewValue[.='']">
                    <td class="ColData">
                      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                    </td>
                  </xsl:when>
                  <xsl:otherwise>
                    <td class="ColData">
                      <xsl:value-of select="NewValue"/>
                    </td>
                  </xsl:otherwise>
                </xsl:choose>
              </tr>
            </xsl:for-each>
            <xsl:for-each select="ChangedFields/StringFields/Field">
              <xsl:if test="ReferenceName[.!='System.ChangedBy'] and ReferenceName[.!='System.ChangedDate']">
                <tr>
                  <td class="Col1Data">
                    <xsl:value-of select="Name"/>
                  </td>
                  <xsl:choose>
                    <xsl:when test="NewValue[.='']">
                      <td class="ColData">
                        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                      </td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td class="ColData">
                        <xsl:value-of select="NewValue"/>
                      </td>
                    </xsl:otherwise>
                  </xsl:choose>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </table>
        </xsl:if>
      </xsl:if>

      <xsl:if test="boolean(/WorkItemChangedEvent/AddedFiles) or boolean(/WorkItemChangedEvent/AddedResourceLinks) or boolean(/WorkItemChangedEvent/AddedRelations)">
        <br/>
        <!-- _locID_text="LinksAndAttachments" -->Links e Anexos
        <table class="WithBorder">
          <tr>
            <td class="ColHeadingMedium">
              <!-- _locID_text="TypeText" -->Tipo
            </td>
            <td class="ColHeading">
              <!-- _locID_text="DescriptionText" -->Descrição
            </td>
          </tr>

          <xsl:for-each select="AddedFiles/AddedFile">
            <tr>
              <td class="Col1Data">
                <!-- _locID_text="FileAttachmentText" -->Arquivo Anexo
              </td>
              <td class="ColData">
                <xsl:value-of select="Name"/>
              </td>
            </tr>
          </xsl:for-each>

          <xsl:for-each select="AddedResourceLinks/AddedResourceLink">
            <tr>
              <td class="Col1Data">
                <!-- _locID_text="LinkText" -->Link
              </td>
              <td class="ColData">
                <xsl:value-of select="Resource"/>
              </td>
            </tr>
          </xsl:for-each>

          <xsl:for-each select="AddedRelations/AddedRelation">
            <tr>
              <td class="Col1Data">
                <xsl:choose>
                  <xsl:when test="string-length(LinkName)">
                    <xsl:value-of select="LinkName"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- _locID_text="RelatedWorkItem" -->Relacionado
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td class="ColData">
                <xsl:value-of select="WorkItemId"/>
              </td>
            </tr>
          </xsl:for-each>

        </table>
      </xsl:if>

      <xsl:if test="boolean(/WorkItemChangedEvent/DeletedFiles)">
        <br/>
          <!-- _locID_text="OneOrMoreAttachmentsDeleted"-->1 ou mais anexos foram excluídos.  Veja o work item para mais detalhes.
      </xsl:if>

      <xsl:if test="boolean(/WorkItemChangedEvent/DeletedResourceLinks)">
        <br/>
          <!-- _locID_text="OneOrMoreLinksDeleted"-->1 ou mais links foram excluídos.  Veja o work item para mais detalhes.
      </xsl:if>

      <xsl:if test="boolean(/WorkItemChangedEvent/ChangedResourceLinks)">
        <br/>
          <!-- _locID_text="OneOrMoreLinksChanged"-->1 ou mais links foram modificados.  Veja o work item para mais detalhes.
      </xsl:if>

      <xsl:if test="boolean(/WorkItemChangedEvent/DeletedRelations)">
        <br/>
          <!-- _locID_text="OneOrMoreRelatedWorkItemsDeleted"-->1 ou mais work items relacionados foram excluídos.  Veja o work item para mais detalhes.
      </xsl:if>

      <xsl:if test="boolean(/WorkItemChangedEvent/ChangedRelations)">
        <br/>
          <!-- _locID_text="OneOrMOreRelatedWorkItemsChanged"-->1 ou mais work items relacionados foram modificados.  Veja o work item para mais detalhes.
      </xsl:if>

      <xsl:call-template name="footer">
        <xsl:with-param name="format" select="'html'"/>
        <xsl:with-param name="alertOwner" select="Subscriber"/>
        <xsl:with-param name="timeZoneOffset" select="TimeZoneOffset"/>
        <xsl:with-param name="timeZoneName" select="TimeZone"/>
      </xsl:call-template>
    </body>
  </xsl:template>
</xsl:stylesheet>
