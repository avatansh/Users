<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://www.tibco.com/asg/content-types/form"
xmlns:c="http://www.tibco.com/schemas/asg/context"
xmlns:h="http://www.tibco.com/asg/protocols/http"
xmlns:form="http://www.tibco.com/asg/functions/form" exclude-result-prefixes="xsl h c f form">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
<xsl:variable name="context">
<xsl:for-each select="/transformation/context">
   <xsl:copy-of select="document(@href)"/>
</xsl:for-each>
</xsl:variable>
<xsl:variable name="httpRequest">
<xsl:copy-of select="$context/c:context/c:entry[@key='asg:httpRequest']/h:request"/>
</xsl:variable>		
   <xsl:variable name="request-uri">
   <xsl:copy-of select="$httpRequest/h:request/h:request-uri"/>
   </xsl:variable>		
   <xsl:template match="/">	
   <output>
   <key type="requestURI" log="true">
     <xsl:copy-of select="normalize-space($request-uri)"/>
   </key>
   <key type="clientIP" log="true">
   <xsl:choose>
   <xsl:when    test="$httpRequest/h:request/h:header[lower-case(@name)='x-forw   arded-for']">
   <xsl:value-of    select="$httpRequest/h:request/h:header[lower-case(@name)='x-fo   rwarded-for']"/>
   </xsl:when>
   <xsl:otherwise>
     <xsl:value-of select="$httpRequest/h:request/h:client-ip"/>
   </xsl:otherwise>
   </xsl:choose>
   </key>
   <xsl:for-each select="$httpRequest/h:request/h:header">
   <xsl:variable name="hdr_name" select="@name"/>
   <xsl:if test="lower-case($hdr_name)='host'">
     <key type="host" log="true">
     <xsl:value-of select="."/>
     </key>
   </xsl:if>
   <xsl:if test="lower-case($hdr_name)='apikey'">
     <key type="apikey" log="true">
     <xsl:value-of select="."/>
     </key>
   </xsl:if>
   <xsl:if test="lower-case($hdr_name)='referer'">
     <key type="referer" log="true">
     <xsl:value-of select="."/>
     </key>
   </xsl:if>
   <xsl:if test="lower-case($hdr_name)='user-agent'">
     <key type="useragent" log="true">
     <xsl:value-of select="."/>
     </key>
   </xsl:if>			
</xsl:for-each>
   </output>
   </xsl:template>
   </xsl:stylesheet>