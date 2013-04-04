require "matrix"

debug = false

input = debug ? STDIN : File.new("DATA4.txt","r")
output = debug ? STDOUT : File.open("OUT4.txt", 'w')

$totaltrees = 0

def anyneighbor(row,col)
	if 	yield(row+1,col) || yield(row-1,col) ||
		yield(row,col+1) || yield(row,col-1)
		return true
	end
end
def iter(mat)
	newmat = Marshal.load(Marshal.dump(mat))
	changed = false
	mat.each_with_index do |r,row|
		r.each_with_index do |e,col|
			if e == "T" && anyneighbor(row,col) { |nrow,ncol| (0...mat.length) === nrow && (0...mat[0].length) === ncol && mat[nrow][ncol] == "F"}
				newmat[row][col] = "F"
				$totaltrees -= 1
				changed = true
			end
		end
	end
	return newmat,changed
end

5.times do |c|
	map = []
	10.times do
		map << input.gets.chomp.split(//)
	end
	# count 'em'
	map.each do |row|
		row.each { |e|
			$totaltrees += 1 if e == "T"
		}
	end
	its = 0
	while true
		break if $totaltrees == 0
		map,changed = iter(map)
		its += 1
		#p map,its if c == 2 
		break if $totaltrees == 0
		if !changed
			its = -1
			break
		end
	end
	output.puts its

	$totaltrees = 0
	input.gets #separator
end