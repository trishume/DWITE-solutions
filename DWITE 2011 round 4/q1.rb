debug = true

input = debug ? STDIN : File.new("DATA5.txt","r")
output = debug ? STDOUT : File.open("OUT5.txt", 'w')

def filled(p,map)
	return true if p[1] >= map.length || p[]
	return true if p[0] >= map.length
end

5.times do
	h = input.gets.chomp.split[0].to_i
	map = []
	h.times do
		map << input.gets.split(//).map { |e| e == '#' }
	end
	p map
end