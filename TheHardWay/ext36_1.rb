h = {}

def h.[]=(k, v)
  puts "Setting hash key #{k} with #{v.inspect}"
  super
end

h[:x] ||= 10
h[:x] ||= 20

h[:y] = h[:y] || 10
h[:y] = h[:y] || 20

h[:z] || h[:z] = 10
h[:z] || h[:z] = 20