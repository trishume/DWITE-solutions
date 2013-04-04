debug = false

input = debug ? STDIN : File.new("DATA1.txt","r")
output = debug ? STDOUT : File.open("OUT1.txt", 'w')

R = [1,0]
D = [0,-1]

def adddir(loc,move)
  [loc[0] + move[0], loc[1] + move[1]]
end

5.times do
  loc = [0,0]
  its = input.gets.to_i
  
  counter = 1
  curdir = R
  curstep = 1
  
  its.times do |i|
    if curstep > counter
      counter += 1
      curstep = 1
      curdir = curdir == R ? D : R
    end
    loc = adddir(loc,curdir)
    curstep += 1
  end
  output.puts loc.join(" ")
end