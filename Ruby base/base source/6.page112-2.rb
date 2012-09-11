module AnotherModule
  def do_stuff
    puts "This is a test"
  end
end

include AnotherModule
do_stuff