class AllVowels
  include Enumerable

  @@vowels = %w{a e i o u}
  def each
    @@vowels.each {|v| yield v}
  end
end

x = AllVowels.new
x.collect {|i| i + "x"}
x.detect {|i| i > "j"}
x.select {|i| i > "j"}
x.sort
x.max
x.min