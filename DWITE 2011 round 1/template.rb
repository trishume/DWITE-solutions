debug = true

input = debug ? STDIN : File.new("infile","r")
output = debug ? STDOUT : File.open("outfile", 'w')