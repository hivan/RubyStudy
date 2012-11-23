module NumberStuff
  def NumberStuff.random
    rand(10000000)
  end
end

module LetterStuff
  def LetterStuff.random
    (rand(26) + 65).chr
  end
end

puts NumberStuff.random
puts LetterStuff.random