<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="hilbert.xslt" /> <!-- import l-rule set here-->
	<xsl:output method="xml" indent="yes" standalone="no" doctype-public="-//W3C//DTD SVG 1.1//EN" doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd" media-type="image/svg" />
	<xsl:param name="n" select="5"/>
	<xsl:param name="x" select="512"/>
	<xsl:param name="y" select="512"/>
	<xsl:param name="width" select="1024"/>
	<xsl:param name="height" select="1024"/>
	<xsl:param name="direction" select="1"/>
	<xsl:param name="step" select="20"/>

	<xsl:template name="main"> <!--controls the workflow to generate svg-->
		<xsl:variable name="initial">
			<xsl:call-template name="initial"/>
		</xsl:variable>
		<xsl:variable name="result-string">
			<xsl:apply-templates select="$initial"> <!--start l-rule application-->
				<xsl:with-param name="n" select="$n"/>
			</xsl:apply-templates>
		</xsl:variable>
		
		<xsl:variable name="points"> <!--generate points from result string-->
		        <xsl:value-of select="concat($x,',', $y, ' ')"/>
			<xsl:apply-templates select="($result-string/*)[1]" mode="scan">
				<xsl:with-param name="direction" select="$direction"/>
				<xsl:with-param name="point">
				     <x><xsl:value-of select="$x"/></x><y><xsl:value-of select="$y"/></y>
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:variable>

		<!--write svg file-->
		<svg xmlns="http://www.w3.org/2000/svg">
		        <xsl:attribute name="width" select="$width"/>
			<xsl:attribute name="height" select="$height"/>
			<polyline fill = "none" stroke = "black" stroke-width = "3">
				<xsl:attribute name="points" select="$points"/>
			</polyline>
		</svg>
	</xsl:template>
	
	<xsl:template match="*"> <!--apply rules up to rucursion step n-->
		<xsl:param name="i" select="0"/>
		<xsl:param name="n"/>
		
		<xsl:if test="number($i) &lt; number($n)">
			<xsl:variable name="pattern">
				<xsl:apply-templates select="." mode="l-rule"/>
			</xsl:variable>
			
			<xsl:apply-templates select="$pattern">
				<xsl:with-param name="i" select="number($i)+number(1)"/>
				<xsl:with-param name="n" select="$n"/>
			</xsl:apply-templates>
		</xsl:if>
		
		<xsl:if test="number($i) &gt;= number($n)">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>
	
	<!-- Scan result string and generate point set-->
	
	<xsl:template match="*" mode="scan">
		<xsl:param name="direction"/>
		<xsl:param name="point"/>
		<xsl:apply-templates select="following-sibling::*[1]" mode="scan">
			<xsl:with-param name="direction" select="$direction"/>
			<xsl:with-param name="point" select="$point"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="f" mode="scan">
		<xsl:param name="direction"/>
		<xsl:param name="point"/>
		
		<xsl:variable name="new-point">
			<x>
				<xsl:value-of select="if (number($direction)=3) then $point/x - $step
										else if (number($direction)=1) then $point/x + $step
										else $point/x"/>
			</x>
			<y>
				<xsl:value-of select="if (number($direction)=0) then $point/y - $step
										else if (number($direction)=2) then $point/y + $step
										else $point/y"/>
			</y>
		</xsl:variable>
		
		<xsl:value-of select="concat($new-point/x,',', $new-point/y, ' ')"/>
		
		<xsl:apply-templates select="following-sibling::*[1]" mode="scan">
			<xsl:with-param name="direction" select="$direction"/>
			<xsl:with-param name="point" select="$new-point"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="l" mode="scan">
		<xsl:param name="direction"/>
		<xsl:param name="point"/>
		<xsl:apply-templates select="following-sibling::*[1]" mode="scan">
			<xsl:with-param name="direction" select="(number($direction) - 1 + 4) mod 4"/>
			<xsl:with-param name="point" select="$point"/>
		</xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="r" mode="scan">
		<xsl:param name="direction"/>
		<xsl:param name="point"/>
		<xsl:apply-templates select="following-sibling::*[1]" mode="scan">
			<xsl:with-param name="direction" select="(number($direction) + 1 + 4) mod 4"/>
			<xsl:with-param name="point" select="$point"/>
		</xsl:apply-templates>
	</xsl:template>
</xsl:stylesheet>