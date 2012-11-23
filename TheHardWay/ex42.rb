class TheThing
  attr_accessor :number

  def initialize()
    @number = 0
  end

  def some_function()
    puts "I got called."
  end

  def add_me_up(more)
    @number += more
    return @number
  end
end

# two different things
a = TheThing.new
b = TheThing.new

a.some_function()
b.some_function()

puts a.add_me_up(100)
puts a.add_me_up(20)
puts b.add_me_up(30)
puts b.add_me_up(30)

puts a.number
puts b.number