<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei" version="2.0">
    <xsl:import href="shared/base_index.xsl"/>
    <xsl:param name="entiyID"/>
    <xsl:variable name="entity" as="node()">
        <xsl:choose>
            <xsl:when test="not(empty(//tei:place[@xml:id=$entiyID][1]))">
                <xsl:value-of select="//tei:place[@xml:id=$entiyID][1]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="false()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:template match="/">
        <xsl:if test="$entity">
            <div class="modal" tabindex="-1" role="dialog" id="myModal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <xsl:choose>
                            <xsl:when test="$entity">
                                <xsl:variable name="entity" select="//tei:place[@xml:id=$entiyID]"/>
                                <div class="modal-header">

                                    <h3 class="modal-title">
                                        <xsl:value-of select="$entity/tei:placeName[1]"/>
                                        <br/>
                                        <small>
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="concat('hits.html?searchkey=', $entiyID)"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="target">_blank</xsl:attribute>
                                                erwähnt in
                                            </a>
                                        </small>
                                    </h3>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">x</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <table class="table table-boardered table-hover">
                                        <tr>
                                            <th>Name</th>
                                            <td>
                                                <xsl:value-of select="//tei:place[@xml:id=$entiyID]/tei:placeName[1]"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Alternative Bezeichnungen</th>
                                            <td>
                                                <ul>
                                                <xsl:for-each select="subsequence($entity//tei:placeName[position()&gt;1], 1, 3)">
                                                    <li><xsl:value-of select="."/></li>
                                                </xsl:for-each>
                                                </ul>
                                            </td>
                                        </tr>

                                        <xsl:if test="$entity/tei:idno[@type='URL']">
                                            <tr>
                                                <th>URL:</th>
                                                <td>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="$entity/tei:idno[@type='URL']/text()"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="$entity/tei:idno[@type='URL']/text()"/>
                                                    </a>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="$entity/tei:idno">
                                            <tr>
                                                <th>URL:</th>
                                                <td>
                                                    <xsl:for-each select="$entity/tei:idno">
                                                        <p>
                                                            <a target="_blank" title="Öffnet Link in einenm neuen Tab">
                                                                <xsl:attribute name="href">
                                                                    <xsl:value-of select="./text()"/>
                                                                </xsl:attribute>
                                                                <xsl:value-of select="./text()"/>
                                                            </a>
                                                        </p>
                                                    </xsl:for-each>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                    </table>
                                </div>
                            </xsl:when>
                        </xsl:choose>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Schließen</button>
                        </div>
                    </div>
                </div>
            </div>
        </xsl:if>
        <script type="text/javascript">
            $(window).load(function(){
            $('#myModal').modal('show');
            });
        </script>
    </xsl:template>
</xsl:stylesheet>
