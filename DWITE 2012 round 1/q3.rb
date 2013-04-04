debug = false

input = debug ? STDIN : File.new("DATA3.txt","r")
out = debug ? STDOUT : File.open("OUT3.txt", 'w')

5.times do
  n = input.gets.to_i
  used = {}
  collisions = []
  n.times do
  	line = input.gets.split(" ")
  	costume = line[1]
  	if used[costume]
  		collisions << line[0]
  	else
  		used[costume] = true
  	end
  end
  if collisions.length > 0
  	out.puts collisions.join(" ")
  else
  	out.puts "SPOOKY"
  end
end