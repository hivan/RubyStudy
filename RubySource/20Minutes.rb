#!/Usr/hivan/bin/env ruby
class MegaGreeter
  attr_accessor :names

  #初始化这个物件
  def initialize(names = "world!")
    @names = names
  end

  #向每个人说hi
  def say_hi
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("each")

      # @names 是可以迭代的阵列容器
      @names.each do |name|
        puts "Hello #{name}!"
      end
    else
      puts "Hello #{@names}!"
    end
  end

  #向每个人说Bye
  def say_bye
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("join")
      #用逗号将阵列中的元素串接程一个字串
      puts "Goodbye #{@names.join(", ")}, Come back soon!"
    else
      puts "Goodbye #{@names}. Come back soon!"
    end
  end

end

if __FILE__ == $0
  mg = MegaGreeter.new
  mg.say_hi
  mg.say_bye

  #变更成"Zeke"
  mg.names = "Zeke"
  mg.say_hi
  mg.say_bye

  #变更成一个名字的阵列
  mg.names = ["Albert", "Brenda", "Charles", "Dave", "Englebert"]
  mg.say_hi
  mg.say_bye

  #变更成nil
  mg.names = nil
  mg.say_hi
  mg.say_bye
end























