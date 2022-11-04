<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="2"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" />
	<xsl:template match="/">
		<xsl:for-each select="Document/Folder/Placemark">
			<!-- GEPLAND Test -->
			<xsl:for-each select="ExtendedData/SchemaData/SimpleData">
				<xsl:if test="(@name = 'Gebruik') and (.!='GEPLAND')">
					
					<!-- Start insert statement -->
					<xsl:text>INSERT INTO STATIONS (StationId, ObjectId, GPSCoord, StationNr, Type, Street, Number, ZipCode, District, AdditionalInfo) VALUES (</xsl:text>
					
					<!-- StationId (Counter) -->
					<xsl:number count="Placemark" />
					<xsl:text>, </xsl:text>
					
					<!-- ObjectId -->
					<xsl:for-each select="../SimpleData">
						<xsl:if test="@name = 'OBJECTID'">
							<xsl:value-of select="."/>
							<xsl:text>, </xsl:text>
						</xsl:if>
					</xsl:for-each>
					
					<!-- Coordinates -->
					<xsl:text>geometry::STGeomFromText('POINT(</xsl:text>
					<xsl:value-of select="substring-before(../../../Point/coordinates, ',')"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="substring-after(../../../Point/coordinates, ',')"/>
					<xsl:text>)', 4326), </xsl:text>
					
					<!-- StationNr -->
					<xsl:for-each select="../SimpleData">
						<xsl:if test="@name = 'Objectcode'">
							<xsl:value-of select="substring(., string-length(.) - 2)"/>
							<xsl:text>, </xsl:text>
						</xsl:if>
					</xsl:for-each>
					
					<!-- Type -->
					<xsl:for-each select="../SimpleData">
						<xsl:if test="@name = 'Type_velo'">
							<xsl:text>'</xsl:text>
							<xsl:value-of select="normalize-space(.)"/>
							<xsl:text>', </xsl:text>
						</xsl:if>
					</xsl:for-each>
					
					<!-- Street -->
					<xsl:for-each select="../SimpleData">
						<xsl:if test="@name = 'Straatnaam'">
							<xsl:text>'</xsl:text>
							<xsl:value-of select="normalize-space(.)"/>
							<xsl:text>', </xsl:text>
						</xsl:if>
					</xsl:for-each>
					<xsl:if test="not(boolean(../SimpleData/@name = 'Straatnaam'))">
						<xsl:text>'ONTBREKEND', </xsl:text>
					</xsl:if>
					
					<!-- Number -->
					<xsl:for-each select="../SimpleData">
						<xsl:if test="@name = 'Huisnummer'">
							<xsl:text></xsl:text>
							<xsl:value-of select="normalize-space(.)"/>
							<xsl:text>, </xsl:text>
						</xsl:if>
					</xsl:for-each>
					<xsl:if test="not(boolean(../SimpleData/@name = 'Huisnummer'))">
						<xsl:text>NULL, </xsl:text>
					</xsl:if>
					
					<!-- ZipCode -->
					<xsl:for-each select="../SimpleData">
						<xsl:if test="@name = 'Postcode'">
							<xsl:value-of select="normalize-space(.)"/>
							<xsl:text>, </xsl:text>
						</xsl:if>
					</xsl:for-each>
					
					<!-- District -->
					<xsl:for-each select="../SimpleData">
						<xsl:if test="@name = 'District'">
							<xsl:text>'</xsl:text>
							<xsl:value-of select="normalize-space(.)"/>
							<xsl:text>', </xsl:text>
						</xsl:if>
					</xsl:for-each>
					
					<!-- AdditionalInfo -->
					<xsl:for-each select="../SimpleData">
						<xsl:if test="@name = 'Aanvulling'">
							<xsl:text>'</xsl:text>
							<xsl:value-of select="normalize-space(.)"/>
							<xsl:text>'</xsl:text>
						</xsl:if>
					</xsl:for-each>
					<xsl:if test="not(boolean(../SimpleData/@name = 'Aanvulling'))">
						<xsl:text>NULL</xsl:text>
					</xsl:if>
					
					<!-- Finish insert statement -->
					<xsl:text>);&#xa;</xsl:text>
					
				</xsl:if>
			</xsl:for-each>
			
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
