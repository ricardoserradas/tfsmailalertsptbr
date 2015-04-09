<?xml version='1.0'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:b="http://schemas.microsoft.com/TeamFoundation/2010/Build">
    <xsl:import href="TeamFoundation.xsl"/>
    <!-- Common TeamSystem elements -->
    <xsl:template name="GetTime">
        <xsl:param name="seconds"/>
        <xsl:variable name="hours" select="round($seconds div 3600)" />
        <xsl:variable name="minutes" select ="round(($seconds mod 3600) div 60)"/>
        <xsl:if test="$hours &lt; 12">
            <xsl:value-of select="format-number($hours, '00')"/>
            <xsl:text>:</xsl:text>
            <xsl:value-of select="format-number($minutes, '00')"/>
            <xsl:text>AM</xsl:text>
        </xsl:if>
        <xsl:if test="$hours &gt;= 12">
            <xsl:value-of select="format-number($hours - 12, '00')"/>
            <xsl:text>:</xsl:text>
            <xsl:value-of select="format-number($minutes, '00')"/>
            <xsl:text>PM</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="BuildDefinitionChangedEvent">
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
                    <td class="BoldPropName" _locID="EventAction">Action: </td>
                    <td class="BoldPropValue">
                        <b>
                            <xsl:value-of select="@ChangedType"/>
                        </b>
                    </td>
                </tr>
                <tr>
                    <td class="PropName" _locID="ResourceType">Resource Type: </td>
                    <td class="PropValue">
                        <xsl:value-of select="@ResourceType" />
                    </td>
                </tr>
                <tr>
                    <td class="PropName" _locID="Name">Name: </td>
                    <td class="PropValue">
                        <xsl:value-of select="@Name"/> (<xsl:value-of select="@Uri" />)
                    </td>
                </tr>
                <tr>
                    <td class="PropName" _locID="ChangedBy">Changed by: </td>
                    <td class="PropValue">
                        <xsl:value-of select="@ChangedBy"/>
                    </td>
                </tr>
                <br/>
                <xsl:choose>
                    <xsl:when test="@ChangedType = 'Added'">
                        <xsl:for-each select="b:PropertyChanges/b:PropertyChange">
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
                        <xsl:for-each select="b:RetentionPolicyChanges/b:PropertyChangeOfRetentionPolicy">
                            <tr>
                                <td class="PropName">
                                    Retention Policy[<xsl:value-of select="position()"/>]:
                                </td>
                                <td class="PropValue">
                                    <xsl:for-each select="b:NewValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=<b>
                                            <xsl:value-of select="."/>
                                        </b>,
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </xsl:for-each>
                        <xsl:for-each select="b:ScheduleChanges/b:PropertyChangeOfSchedule">
                            <tr>
                                <td class="PropName">Schedule:</td>
                                <td class="PropValue">
                                    <xsl:for-each select="b:NewValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()"/>=<b>
                                            <xsl:if test="name() !='UtcStartTime'">
                                                <xsl:value-of select="."/>,
                                            </xsl:if>
                                            <xsl:if test="name() = 'UtcStartTime'">
                                                <xsl:call-template name="GetTime">
                                                    <xsl:with-param name="seconds" select="."/>
                                                </xsl:call-template>,
                                            </xsl:if>
                                        </b>
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </xsl:for-each>
                        <xsl:for-each select="b:WorkspaceMappingChanges/b:PropertyChangeOfWorkspaceMapping">
							<tr>
								<td class="PropName">
									Workspace Mapping[<xsl:value-of select="position()"/>]:
								</td>
								<td class="PropValue">
									<xsl:for-each select="b:NewValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=<b>
											<xsl:value-of select="."/>
										</b>,
									</xsl:for-each>
								</td>
							</tr>
						</xsl:for-each>

                    </xsl:when>

                    <xsl:when test="@ChangedType = 'Updated'">
                        <xsl:for-each select="b:PropertyChanges/b:PropertyChange">
                            <xsl:sort select="@Name"/>
                            <tr>
								<td class="PropName">
									<b>
										<xsl:value-of select="@Name" />
									</b>:
								</td>
							</tr>
							<tr>
								<td class="PropName">&#160;&#160;&#160;&#160;Old Value:</td>
								<td class="PropValue">
                                    <xsl:value-of select="b:OldValue" />
                                </td>
                            </tr>
                            <tr>
								<td class="PropName">&#160;&#160;&#160;&#160;New Value:</td>
                                <td class="PropValue">
                                    <xsl:value-of select="b:NewValue" />
                                </td>
                            </tr>
                        </xsl:for-each>
                        <xsl:for-each select="b:RetentionPolicyChanges/b:PropertyChangeOfRetentionPolicy">
                            <tr>
                                <td class="PropName">
									<b>Retention Policy[<xsl:value-of select="position()"/>]</b>:
                                </td>
                            </tr>
                            <tr>
                                <td class="PropName">
                                    <xsl:text>&#160;&#160;Old Value:</xsl:text>
                                </td>
                                <td class="PropValue">
                                    <xsl:for-each select="b:OldValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=<xsl:value-of select="."/>,
                                    </xsl:for-each>
                                </td>
                            </tr>
                            <tr>
                                <td class="PropName">
                                    <xsl:text>&#160;&#160;New Value</xsl:text>:
                                </td>
                                <td class="PropValue">
                                    <xsl:for-each select="b:NewValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=<b>
                                            <xsl:value-of select="."/>
                                        </b>,
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </xsl:for-each>
                        <xsl:for-each select="b:ScheduleChanges/b:PropertyChangeOfSchedule">
                            <tr>
                                <td class="PropName">
                                    <b>Schedule</b>:
                                </td>
                            </tr>
                            <tr>
                                <td class="PropName">
                                    <xsl:text>&#160;&#160;Old Value:</xsl:text>
                                </td>
                                <td class="PropValue">
                                    <xsl:for-each select="b:OldValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=
                                        <xsl:if test="name() !='UtcStartTime'">
                                            <xsl:value-of select="."/>,
                                        </xsl:if>
                                        <xsl:if test="name() = 'UtcStartTime'">
                                            <xsl:call-template name="GetTime">
                                                <xsl:with-param name="seconds" select="."/>
                                            </xsl:call-template>,
                                        </xsl:if>
                                    </xsl:for-each>
                                </td>
                            </tr>
                            <tr>
                                <td class="PropName">
                                    <xsl:text>&#160;&#160;New Value</xsl:text>:
                                </td>
                                <td class="PropValue">
                                    <xsl:for-each select="b:NewValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=<b>
                                            <xsl:if test="name() !='UtcStartTime'">
                                                <xsl:value-of select="."/>,
                                            </xsl:if>
                                            <xsl:if test="name() = 'UtcStartTime'">
                                                <xsl:call-template name="GetTime">
                                                    <xsl:with-param name="seconds" select="."/>
                                                </xsl:call-template>,
                                            </xsl:if>
                                        </b>
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </xsl:for-each>
                        <xsl:for-each select="b:WorkspaceMappingChanges/b:PropertyChangeOfWorkspaceMapping">
							<tr>
								<td class="PropName">
									<b>Workspace Mapping[<xsl:value-of select="position()"/>]</b>:
								</td>
							</tr>
							<tr>
								<td class="PropName">
									<xsl:text>&#160;&#160;Old Value:</xsl:text>
								</td>
								<td class="PropValue">
									<xsl:for-each select="b:OldValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=<xsl:value-of select="."/>,
									</xsl:for-each>
								</td>
							</tr>
							<tr>
								<td class="PropName">
									<xsl:text>&#160;&#160;New Value</xsl:text>:
								</td>
								<td class="PropValue">
									<xsl:for-each select="b:NewValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=<b>
											<xsl:value-of select="."/>
										</b>,
									</xsl:for-each>
								</td>
							</tr>
						</xsl:for-each>
                    </xsl:when>

                    <xsl:when test="@ChangedType = 'Deleted'">
                        <xsl:for-each select="b:PropertyChanges/b:PropertyChange">
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
                        <xsl:for-each select="b:RetentionPolicyChanges/b:PropertyChangeOfRetentionPolicy">
                            <tr>
                                <td class="PropName">
                                    Retention Policy[<xsl:value-of select="position()"/>]:
                                </td>
                                <td class="PropValue">
                                    <xsl:for-each select="b:OldValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=<b>
                                            <xsl:value-of select="."/>
                                        </b>,
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </xsl:for-each>
                        <xsl:for-each select="b:ScheduleChanges/b:PropertyChangeOfSchedule">
                            <tr>
                                <td class="PropName">Schedule:</td>
                                <td class="PropValue">
                                    <xsl:for-each select="b:OldValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()"/>=<b>
                                            <xsl:if test="name() !='UtcStartTime'">
                                                <xsl:value-of select="."/>,
                                            </xsl:if>
                                            <xsl:if test="name() = 'UtcStartTime'">
                                                <xsl:call-template name="GetTime">
                                                    <xsl:with-param name="seconds" select="."/>
                                                </xsl:call-template>,
                                            </xsl:if>
                                        </b>
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </xsl:for-each>
                        <xsl:for-each select="b:WorkspaceMappingChanges/b:PropertyChangeOfWorkspaceMapping">
							<tr>
								<td class="PropName">
									Workspace Mapping[<xsl:value-of select="position()"/>]:
								</td>
								<td class="PropValue">
									<xsl:for-each select="b:OldValue/@*">
                                        <xsl:sort select="name()"/>
                                        <xsl:value-of select="name()" />=<b>
											<xsl:value-of select="."/>
										</b>,
									</xsl:for-each>
								</td>
							</tr>
						</xsl:for-each>

					</xsl:when>
                </xsl:choose>
            </table>
            <br/>
            <xsl:call-template name="footer">
                <xsl:with-param name="format" select="'html'"/>
                <xsl:with-param name="alertOwner" select="b:Subscriber"/>
                <xsl:with-param name="timeZoneOffset" select="b:TimeZoneOffset"/>
                <xsl:with-param name="timeZoneName" select="b:TimeZone"/>
            </xsl:call-template>
        </body>
    </xsl:template>

</xsl:stylesheet>