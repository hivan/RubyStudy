# ARGV 获取传入的参数
filename = ARGV.first

# 赋值变量`prompt`
prompt = "> "
# 获取文件名并传值给txt
txt = File.open(filename)

# 输出一段字元以及文件名
puts "Here's your file: #{filename}"
# 读取文件内容并输出
puts txt.read()

puts "Type the filename again: "
print prompt
file_again = STDIN.gets.chomp()

txt_again = File.open(file_again)

puts txt_again.read()
