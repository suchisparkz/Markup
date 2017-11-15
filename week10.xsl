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
      <th>Years Built</th>
      <th>Architecture</th>
      <th>Description</th>
      <th>Reference</th>
      <th>Image</th>
      <th>Images Count</th>
    </tr>
        <xsl:apply-templates select="historical_places/place">
          <xsl:sort select="location/city" order="descending" data-type="string" />
        </xsl:apply-templates>
      </table>

       <h2>Forts in India</h2>
      <table  align="center">
        <tr>
          <th>Name</th>
      <th>Country</th>
      <th>Dynasty</th>
      <th>Year</th>
      <th>Century</th>
      <th>Years Built</th>
      <th>Architecture</th>
      <th>Description</th>
      <th>Reference</th>
      <th>Image</th>
      <th>Images Count</th>
        </tr>
        <xsl:apply-templates select="historical_places/place[./history/period[@range='start'] &gt; 1635]">
          <xsl:sort select="name" order="ascending" data-type="string" />
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
    <xsl:choose>
      <xsl:when test="dimensions">
        <xsl:apply-templates select="dimensions"/>
      </xsl:when>
      <xsl:otherwise>
        <td>
          N/A
        </td>
      </xsl:otherwise>
    </xsl:choose>
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

  <td> <!-- Calculation -->
      <xsl:value-of select="period[@range='end'] - period[@range='start']"/>
</td>
</xsl:template>

<xsl:template match="dimensions">
  <td><xsl:value-of select="format-number(./width * ./width, '0.#')"/> m<sup>2</sup>
<!--     <xsl:value-of select="ceiling(./width * ./width)"/> m<sup>2</sup>
 --></td>
</xsl:template>



<xsl:template match="description">
  <td id="desc">
    <p><xsl:value-of select="substring(.,1,100)"/>
      <a>
         <xsl:attribute name="href">
            <xsl:value-of select="./@url"/>
          </xsl:attribute>
        Read more...
      </a>
    </p>
  </td>
</xsl:template>

<xsl:template match="website/link[@type='reference']">
  <td>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="./@url"/>
      </xsl:attribute>
      <xsl:value-of select="translate(., 'W', 'w')"/>
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
  <td><xsl:value-of select="count(./image)"/></td>
</xsl:template>


</xsl:stylesheet>