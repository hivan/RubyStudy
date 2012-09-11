#把程序存储为guess.rb
words = ['foobar', 'baz', 'quux']
secret = words[rand(3)]

print "guess?"
while guess = STDIN.gets
  guess.chop!
  if guess == secret
    puts "You win!"
    break
  else
    puts "Sorry, you lose."
  end
   print "guess?"
 end
 puts "The word was " + secret + "."
