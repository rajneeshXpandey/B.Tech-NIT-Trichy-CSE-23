<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>bookstore</title>
            </head>
            <body>
                <table border="1">
                    <tr>
                        <th>title</th>
                        <th>author</th>
                        <th>category</th>
                        <th>isbn</th>
                        <th>publisher</th>
                        <th>edition</th>
                        <th>price</th>
                    </tr>
                    <xsl:for-each select="/bookstore/book">
                        <tr>
                            <td bgcolor="green">
                                <xsl:value-of select="title" />
                            </td>
                            <td bgcolor="red">
                                <xsl:value-of select="author" />
                            </td>
                            <td bgcolor="grey">
                                <xsl:value-of select="category" />
                            </td>
                            <td bgcolor="cyan">
                                <xsl:value-of select="isbn" />
                            </td>
                            <td bgcolor="yellow">
                                <xsl:value-of select="publisher" />
                            </td>
                            <td bgcolor="silver">
                                <xsl:value-of select="edition" />
                            </td>
                            <td bgcolor="blue">
                                <xsl:value-of select="price" />
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>