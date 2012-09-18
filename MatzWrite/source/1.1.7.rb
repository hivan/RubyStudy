#conding: utf-8
#Determine US generation name based on birth year
#Case expression tests ranges with ===
# generation = case birthyear
#   when 1946..1963: "Baby Boomer"
#   when 1964..1975: "Generation X"
#   when 1978..2000: "Generation Y"
#   else nil
#   end

# A method to ask the user to confirm something
def are_you_sure? #Define a method, Note queation mark!
  while true
    print "Are you sure[y/n]: "
    response = gets
    case response
    when /^[yY]/
      return true
    when /^[nN], /^$/
      return false
    end
  end
end