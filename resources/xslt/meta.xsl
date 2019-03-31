<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0"><!-- <xsl:strip-space elements="*"/>-->
    <xsl:import href="shared/base.xsl"/>
    <xsl:param name="document"/>
    <xsl:param name="app-name"/>
    <xsl:param name="collection-name"/>
    <xsl:param name="path2source"/>
    <xsl:param name="ref"/>
    <xsl:param name="prev"/>
    <xsl:param name="next"/>
    <!--
##################################
### Seitenlayout und -struktur ###
##################################
-->
    <xsl:template match="/">
        <div class="container">
            <div class="card">
                <div class="card-header">
                    <div class="row" style="text-align:left">
                        <div class="col-md-2">
                            <xsl:if test="$prev">
                                <h1>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$prev"/>
                                        </xsl:attribute>
                                        <i class="fas fa-chevron-left" title="prev"/>
                                    </a>
                                </h1>
                            </xsl:if>
                        </div>
                        <div class="col-md-8" align="center">
                            <h1>
                                <xsl:value-of select="//tei:title"/>                                
                            </h1>
                           <h5>
                              <i>
                                  <xsl:value-of select="normalize-space(string-join(//tei:author//text(), ' '))"/>
                                </i>
                           </h5>
                        </div>
                        <div class="col-md-2" style="text-align:right">
                            <xsl:if test="$next">
                                <h1>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="$next"/>
                                        </xsl:attribute>
                                        <i class="fas fa-chevron-right" title="next"/>
                                    </a>
                                </h1>
                            </xsl:if>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <xsl:apply-templates select="//tei:body"/>
                </div>
                <hr/>
                <xsl:for-each select=".//tei:note">
                    <div class="footnotes">
                        <xsl:element name="a">
                            <xsl:attribute name="name">
                                <xsl:text>fn</xsl:text>
                                <xsl:number level="any" format="1" count="tei:note"/>
                            </xsl:attribute>
                                <xsl:attribute name="href">
                                    <xsl:text>#fna_</xsl:text>
                                    <xsl:number level="any" format="1" count="tei:note"/>
                                </xsl:attribute>
                                <span style="font-size:7pt;vertical-align:super;">
                                    <xsl:number level="any" format="1" count="tei:note"/>
                                </span>
                        </xsl:element>
                        <xsl:apply-templates/>
                    </div>
                </xsl:for-each>
                <div class="card-footer text-muted" style="text-align:center;">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$path2source"/>
                        </xsl:attribute>
                        see the TEI source of this document
                    </a>
                </div>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>