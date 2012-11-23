# 与其使用这种格式化字串
name1 = "Joe"   # 赋值变量name1
name2 = "Mary"  # 赋值变量name2
puts "Hello %s, where is %s?" %[name1, name2]   # 引入变量name1，name2

# 我们可以键入
name1 = "Joe"
name2 = "Mary"
puts "Hello #{name1}, where is #{name2}?"   # 利用插写来引入

# 学会使用恼人地隐晦简写来节省打字时间
x = "There are #{10} types of people." 
binary = "binary"
do_not = "don't"
y = "Those who know #{binary} and those who #{do_not}."

puts x
puts y

puts "I said: #{x}."
puts "I also sid: '#{y}'."

hilarious = false
joke_evaluation = "Isn't that joke so funy?! #{hilarious}"

puts joke_evaluation

w = "This is the left side of..."
e = "a string whith a right side."

puts w + e
