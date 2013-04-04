debug = false

input = debug ? STDIN : File.new("DATA1.txt","r")
out = debug ? STDOUT : File.open("OUT1.txt", 'w')

require 'time'

5.times do |i|
  line = input.gets.split
  time = Time.parse(line[0])
  delta = line[1].to_i + line[2].to_i
  new_time = time + (delta * 60 * 60)
  out.puts new_time.strftime("%H:%M:%S")
end
