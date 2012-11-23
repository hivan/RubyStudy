# first, second, third = ARGV

# puts "The script is called: #{$0}"
# puts "Your first variable is: #{first}"
# puts "Your second variable is #{second}"
# puts "Your third variable is: #{third}"

# # 更多地脚本

# the1, the2, the3, the4, the5 = ARGV

# puts "The script is called: #{$0}"
# puts "Your first variable is: #{the1}"
# puts "Your second variable is #{the2}"
# puts "Your third variable is: #{the3}"
# puts "Your fourth variable is: #{the4}"

# 结合使用

age, height, weight = ARGV

print "How old are you? "
age = gets.chomp()
print "How tall are you? "
height = gets.chomp()
print "How much do you weigh? "
weight = gets.chomp()

puts "The script is called: #{$0}"
puts "The person is old: #{age}"
puts "The person is tall: #{height}"
puts "The person is heavy: #{weight}"
