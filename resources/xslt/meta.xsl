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


                        <div class="col-md-12" align="center">
                            <h1>
                                <xsl:value-of select="//tei:title"/>
                            </h1>
                            <a href="{$path2source}">
                                <i class="fas fa-download" title="show TEI source"/>
                            </a>
                           <h5>
                              <i>
                                  <xsl:value-of select="normalize-space(string-join(//tei:author//text(), ' '))"/>
                                </i>
                           </h5>
                        </div>


                </div>
                <div class="card-body">
                    <div class="card">

                            <div class="card-body">
                                <xsl:for-each select="//tei:head">
                                <li>
                                    <xsl:value-of select="./text()"/>
                                </li>
                            </xsl:for-each>
                            </div>
                    </div>
                    <xsl:apply-templates select="//tei:body"/>
                </div>

                <div class="card-footer">
                    <p style="text-align:center;">
                        <xsl:for-each select=".//tei:note">
                            <div class="footnotes">
                                <xsl:element name="a">
                                    <xsl:attribute name="name">
                                        <xsl:text>fn</xsl:text>
                                        <xsl:number level="any" format="1" count="tei:note"/>
                                    </xsl:attribute>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:text>#fna_</xsl:text>
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                        </xsl:attribute>
                                        <span style="font-size:7pt;vertical-align:super; margin-right: 0.4em">
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                        </span>
                                    </a>
                                </xsl:element>
                                <xsl:value-of select=".//text()"/>
                            </div>
                        </xsl:for-each>
                    </p>
                    <p>
                        <hr/>
                        <h3>Zitierhinweis</h3>
                        <blockquote class="blockquote">
                            <cite title="Source Title">
                                Christof Aichner, Die Korrespondenz von Leo von Thun-Hohenstein, https://thun-korrespondenz.acdh.oeaw.ac.at/pages/show.html?document=about.xml&amp;directory=meta</cite>
                        </blockquote>
                    </p>
                </div>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
