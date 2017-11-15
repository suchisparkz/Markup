<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
    <link rel="stylesheet" type="text/css" href="style.css"/>
  </head>
    <body>
      <h2>Historical places in India</h2>
      <table align="center">
        <tr>
      <th>Name</th>
      <th>Country</th>
      <th>Dynasty</th>
      <th>Year</th>
      <th>Century</th>
      <th>Description</th>
      <th>Reference</th>
      <th>Image</th>
    </tr>
        <xsl:apply-templates select="historical_places/place">
          <xsl:sort select="location" order="ascending" data-type="string" />
        </xsl:apply-templates>
      </table>
    </body>
  </html>
</xsl:template>

<xsl:template match="place">
  <tr>
    <xsl:apply-templates select="name[@language='english']"/>
    <xsl:apply-templates select="location"/>
    <xsl:apply-templates select="history"/>
    <xsl:apply-templates select="description"/>
    <xsl:apply-templates select="website/link[@type='reference']"/>
    <xsl:apply-templates select="images"/>
  </tr>
</xsl:template>

<xsl:template match="name[@language='english']">
  <td>
    <xsl:value-of select="."/>
  </td>
</xsl:template>

<xsl:template match="location">
  <td>
    <p><xsl:value-of select="city"/>, <xsl:value-of select="./country"/></p>
  </td>
</xsl:template>

<xsl:template match="history">
  <td>
    <xsl:value-of select="./dynasty"/>
  </td>
  <td>
    <xsl:value-of select="period"/>
  </td>
  <td>
    <xsl:text> 16 </xsl:text>
  </td>
</xsl:template>

<xsl:template match="description">
  <td id="desc">
    <p><xsl:value-of select="."/></p>
  </td>
</xsl:template>

<xsl:template match="website/link[@type='reference']">
  <td>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="./@url"/>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </a>
  </td>
</xsl:template>

<xsl:template match="images">
  <td>
    <img>
          <xsl:attribute name="src">
              <xsl:value-of select="image[@type='gif'][position() = last()]"/>
          </xsl:attribute>
        </img>
  </td>
</xsl:template>

</xsl:stylesheet>