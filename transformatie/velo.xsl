<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="2"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" />
	<xsl:template match="/">
			<!-- GEPLAND Test -->
			<xsl:for-each select="/kml/Document/Folder/Placemark/ExtendedData/SchemaData[SimpleData[@name='Gebruik']!='GEPLAND']">
				<!-- <xsl:if test="(@name = 'Gebruik') and (.!='GEPLAND')"> -->
					
					<!-- Start insert statement -->
					<xsl:text>INSERT INTO STATIONS (StationId, ObjectId, GPSCoord, StationNr, Type, Street, Number, ZipCode, District, AdditionalInfo) VALUES (</xsl:text>
					
					<!-- StationId (Counter) -->
					<countNo><xsl:value-of select="position()" /></countNo>
					<xsl:text>, </xsl:text>
					
					<!-- ObjectId -->
					<xsl:value-of select="normalize-space(SimpleData[@name='OBJECTID'])"/>
					<xsl:text>, </xsl:text>

					<!-- Coordinates -->
					<xsl:text>geometry::STGeomFromText('POINT(</xsl:text>
					<xsl:value-of select="substring-before(../../Point/coordinates, ',')"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="substring-after(../../Point/coordinates, ',')"/>
					<xsl:text>)', 4326), </xsl:text>
					
					<!-- StationNr -->
					<xsl:if test="SimpleData[@name='Objectcode']">
						<xsl:value-of select="substring(SimpleData[@name='Objectcode'], string-length(SimpleData[@name='Objectcode']) - 2)"/>
						<xsl:text>, </xsl:text>
					</xsl:if>
					
					<!-- Type -->
					<xsl:if test="SimpleData[@name='Type_velo']">
					<xsl:text>'</xsl:text>
						<xsl:value-of select="normalize-space(SimpleData[@name='Type_velo'])"/>
					<xsl:text>', </xsl:text>
					</xsl:if>
					<xsl:if test="not(boolean(SimpleData/@name = 'Type_velo'))">
						<xsl:text>'ONTBREKEND', </xsl:text>
					</xsl:if>
					
					<!-- Street -->
					<xsl:if test="SimpleData[@name='Straatnaam']">
						<xsl:text>'</xsl:text>
						<xsl:value-of select="normalize-space(SimpleData[@name='Straatnaam'])"/>
						<xsl:text>', </xsl:text>
					</xsl:if>
					<xsl:if test="not(boolean(SimpleData/@name = 'Straatnaam'))">
						<xsl:text>'ONTBREKEND', </xsl:text>
					</xsl:if>
					
					<!-- Number -->
						<xsl:if test="SimpleData[@name='Huisnummer']">
							<xsl:text>'</xsl:text>
							<xsl:value-of select="normalize-space(SimpleData[@name='Huisnummer'])"/>
							<xsl:text>', </xsl:text>
						</xsl:if>
					<xsl:if test="not(boolean(SimpleData/@name = 'Huisnummer'))">
						<xsl:text>NULL, </xsl:text>
					</xsl:if>
					
					<!-- ZipCode -->
						<xsl:if test="SimpleData[@name='Postcode']">
							<xsl:value-of select="normalize-space(SimpleData[@name='Postcode'])"/>
							<xsl:text>, </xsl:text>
						</xsl:if>
					
					<!-- District -->
						<xsl:if test="SimpleData[@name='District']">
							<xsl:text>'</xsl:text>
							<xsl:value-of select="normalize-space(SimpleData[@name='District'])"/>
							<xsl:text>', </xsl:text>
						</xsl:if>
					
					<!-- AdditionalInfo -->
						<xsl:if test="SimpleData[@name='Aanvulling']">
							<xsl:text>'</xsl:text>
							<xsl:value-of select="normalize-space(SimpleData[@name='Aanvulling'])"/>
							<xsl:text>'</xsl:text>
						</xsl:if>
					<xsl:if test="not(boolean(SimpleData[@name='Aanvulling']))">
						<xsl:text>NULL</xsl:text>
					</xsl:if>
					
					<!-- Finish insert statement -->
					<xsl:text>);&#xa;</xsl:text>
					
				<!-- </xsl:if> -->
			</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>