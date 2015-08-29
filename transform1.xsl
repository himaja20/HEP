<?xml version="1.0"?>
<xsl:stylesheet xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:strip-space elements="*"/>       
    <xsl:template match="doc">
        <TEI.2>
            <xsl:apply-templates />
        </TEI.2>
    </xsl:template>
    <xsl:template match="mepHeader">
        <teiHeader>
            <fileDesc>
                <xsl:apply-templates/>
            </fileDesc>
            <profileDesc>
                <creation>
                    <date>
                        <xsl:attribute name="value">
                            <xsl:value-of select="docDate/@value" />
                        </xsl:attribute>
                        <xsl:value-of select="docDate" />
                    </date>
                </creation>
            </profileDesc>
            <revisionDesc>
                <xsl:apply-templates select="prepDate" />                            
            </revisionDesc>
            </teiHeader>
    </xsl:template>
    
    <xsl:template match="prepDate">
      <xsl:for-each select="prepDate">
         <change>
          <xsl:call-template name="tokenize">
              <xsl:param name="prepDate" select = "." />
          </xsl:call-template>
         </change> 
     </xsl:for-each>
    </xsl:template>

    <xsl:template name="tokenize">
      <xsl:param name="prepDate" />
         <xsl:variable name="first-item" select="normalize-space(substring-before( concat( $prepDate, ' '), ' '))" /> 
            <xsl:if test="$first-item">
              <date>
                <xsl:value-of select="$first-item" /> 
              </date>  
              <xsl:call-template name="tokenize"> 
                <xsl:with-param name="prepDate" select="substring-after($prepDate,' ')" /> 
              </xsl:call-template>    
            </xsl:if>  
   </xsl:template> 

    <xsl:template match="docDate" />
                
    <xsl:template match="docAuthor" />
    <xsl:template match="docTitle">
        <titleStmt>
            <xsl:apply-templates />
            <author>
                <xsl:value-of select="//docAuthor" />
            </author>
            <xsl:copy>
                <xsl:copy-of select="//respStmt" />
            </xsl:copy>
        </titleStmt>
    </xsl:template>
    <xsl:template match="docTitle/titlePart">
        <title>
            <reg>
            <xsl:attribute name="resp">
                <xsl:value-of select="supplied/@resp"/>
            </xsl:attribute>
            <xsl:value-of select="//supplied" />
            </reg>
        </title>
    </xsl:template>
    <xsl:template match="idno">
        <publicationStmt>
          <xsl:copy>
            <xsl:copy-of select="idno" />
            <xsl:apply-templates />
          </xsl:copy>
        </publicationStmt>
    </xsl:template>
    <xsl:template match="respStmt" />
    <xsl:template match="sourceDesc">
        <xsl:copy>
            <xsl:copy-of select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="headNote"> 
        <text>
          <front>
            <div type="headnote">
                <note>
                   <xsl:copy-of select="//p" />
                </note>
            </div>
          </front>

        </text>
    </xsl:template>
    
    <xsl:template match="docBody">
      <xsl:element name="body">
         <xsl:attribute name="id">
             <xsl:value-of select="//doc/@type" />
         </xsl:attribute>
         <xsl:copy>
            <xsl:copy-of select="//docBody" />
        </xsl:copy>
      </xsl:element>
    </xsl:template>

</xsl:stylesheet>
