
debug = false

out = debug ? STDOUT : File.open("OUT4.txt", 'w')

5.times do
  out.puts "IMPOSSIBLE"
end
