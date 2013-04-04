cities = 500
conns = 99000

# chain

suffix = "lkfhsdlkfhaslkfhlsdhash"
cur = 1
puts conns + 1
conns.times do
  city = cur.to_s + suffix
  city2 = (cur+1).to_s + suffix
  puts "p #{city} #{city2}"
  cur += 1
end
c = [rand(cities),rand(cities)]
puts "q #{1.to_s + suffix} #{cur.to_s + suffix}"

# random
puts conns + 1
conns.times do
  c = [rand(cities),rand(cities)]
  puts "p #{c[0]} #{c[1]}"
end
c = [rand(cities),rand(cities)]
puts "q #{c[0]} #{c[1]}"

