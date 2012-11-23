# 打开一个预定的文件
filename = ARGV.first
script = $0

# 输出几段文字，内插变量。
puts "We're going to erase #{filename}."
puts "If you don't want that, hit CTRL-C (^c)."
puts "If you do want that, hit RETURN."

print "? "
# 获取键盘的操作，CTRL-C  or RETURN。
STDIN.gets

# 打开文件 使用‘w’模式
puts "Opening the file... "
target = File.open(filename, 'w')

puts "Truncating the file. Goodbye!"
# target.truncate(target.size)

puts "Now I'm going to ask you for three lines."

print "line 1: "; line1 = STDIN.gets.chomp()
print "line 2: "; line2 = STDIN.gets.chomp()
print "line 3: "; line3 = STDIN.gets.chomp()

puts "I'm going to write these to the file."

target.write(line1)
target.write("\n")
target.write(line2)
target.write("\n")
target.write(line3)
target.write("\n")

puts "And finally, we close it."
target.close()
