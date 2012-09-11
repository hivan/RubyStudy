#计算出数字的阶乘
#请把程序存储为fact.rb

def fact(n)
  if n == 0
    1
  else
    n * fact(n-1)
  end
end

puts fact(ARGV[0].to_i)