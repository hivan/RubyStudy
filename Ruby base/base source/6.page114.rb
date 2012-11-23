class AllVowels
  @@vowels = %w{a e i o u}
  def each
    @@vowels.each {|v| yield v}
  end
end

x = AllVowels.new
x.each {|v| puts v}