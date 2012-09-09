my_array = %w{10 56 92 3 49 588 18}
# highest_number = 0
# my_array.each do |number|
#   number = number.to_i
#   highest_number = number if number > highest_number
# end
# puts highest_number

small_number = my_array.length
my_array.each do |number|
  number = number.to_i
  small_number = number if number < small_number
end
puts small_number