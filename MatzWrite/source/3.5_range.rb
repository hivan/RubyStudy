r = 'a'..'c'
r.each {|l| print "[#{l}]"}
r.step(2) {|l| print "[#{l}]"}
r.to_a