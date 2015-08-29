from lxml import etree

dom = etree.parse('xml.xml')
xslt = etree.parse('transform1.xsl')
transform = etree.XSLT(xslt)
newdom = transform(dom)
print(etree.tostring(newdom, pretty_print=True))
