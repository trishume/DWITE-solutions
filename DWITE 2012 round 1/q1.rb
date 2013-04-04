debug = true

input = debug ? STDIN : File.new("DATA1.txt","r")
out = debug ? STDOUT : File.open("OUT1.txt", 'w')

5.times do
  num = input.gets.to_i
  num.times do |i|
  	print "*"(i+1)
  end
  (num-1).downto(1)
end