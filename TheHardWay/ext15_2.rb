prompt = "> "

puts "Please input your file name: "
print prompt
filename = STDIN.gets.chomp()
txt = File.open(filename)

puts "Here's your file: #{filename}"
puts txt.read()