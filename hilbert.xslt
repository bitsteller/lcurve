<?xml version="1.0"?>

<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		>

	<xsl:template name="initial">  <!--initial string/axiom-->
		<A/>
	</xsl:template>
	
	<xsl:template match="*" mode="l-rule">  <!--constants-->
		<xsl:copy-of select="."/>
	</xsl:template>

	<xsl:template match="A" mode="l-rule">
		<l/> <B/> <f/> <r/> <A/> <f/> <A/> <r/> <f/> <B/> <l/>
	</xsl:template>
	
	<xsl:template match="B" mode="l-rule">
		<r/> <A/> <f/> <l/> <B/> <f/> <B/> <l/> <f/> <A/> <r/>
	</xsl:template>
</xsl:stylesheet>