# _*_ coding: utf-8 _*_
euro1 = "\u20AC"
puts euro1
euro1.encoding
euro1.bytesize

euro2 = euro1.encode("iso-8895-15")
puts euro2.inspect
euro2.encoding
euro2.bytesize
euro3 = euro2.encoding("utf-8")
euro1 == euro3