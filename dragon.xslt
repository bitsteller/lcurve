<?xml version="1.0"?>

<xsl:stylesheet version="2.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		>

	<xsl:template name="initial">  <!--initial string/axiom-->
		<F/> <X/>
	</xsl:template>
	
	<xsl:template match="*" mode="l-rule">  <!--constants-->
		<xsl:copy-of select="."/>
	</xsl:template>

	<xsl:template match="X" mode="l-rule">
		<X/> <r/> <Y/> <f/>
	</xsl:template>
	
	<xsl:template match="Y" mode="l-rule">
		<f/> <X/> <l/> <Y/>
	</xsl:template>
</xsl:stylesheet>