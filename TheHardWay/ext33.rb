i = 0
numbers = []

# while i < 6
#   puts "At the top is #{i}"
#   numbers.push(i)

#   i = i+1
#   puts "Numbers now: #{numbers}"
#   puts "At the bottom is #{i}"
# end

def loop()
  (0...6).each{|i| puts i}
  puts "At the top is #{}"
  numbers.push(i)

  puts "Numbers now: #{numbers}"
  puts "At the bottom is #{i}"
end


# for i in (0..5)
#   puts "At the top is #{i}"
#   numbers.push(i)

#   i = i + 1
#   puts "Numbers now: #{numbers}"
#   puts "At the bottom is #{i}"
# end

puts "The numbers:"

for num in numbers
  puts num
end

