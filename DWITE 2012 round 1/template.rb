debug = true

input = debug ? STDIN : File.new("DATA1.txt","r")
out = debug ? STDOUT : File.open("OUT1.txt", 'w')

5.times do
  line = input.gets
  
end