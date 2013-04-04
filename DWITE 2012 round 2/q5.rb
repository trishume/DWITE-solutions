debug = false

input = debug ? STDIN : File.new("DATA5.txt","r")
out = debug ? STDOUT : File.open("OUT5.txt", 'w')

def see(pos)
  starth = $cars[pos]
  max = pos
  pos.upto([$n-1,pos+$m].min) do |i|
    h = $cars[i]
    break unless h <= starth
    max += 1
  end
  min = pos
  pos.downto([0,pos-$m].max) do |i|
    h = $cars[i]
    break unless h <= starth
    min = i
  end
  (min..max-1)
end

def place(cover,startpos)
  maxpos = startpos
  maxcover = -1
  (startpos..(cover+$m)).each do |pos|
    break unless pos < $n
    range = see(pos)
    p startpos if pos == 5
    if range.cover?(cover) && range.max >= maxcover
      maxcover = range.max
      maxpos = pos
    end
  end
  maxpos
end

5.times do |c|
  begin
  $n,$m = input.gets.split.map(&:to_i)
  $cars = []
  $n.times do
    $cars << input.gets.to_i
  end
  start = 0
  cover = 0
  guards = 0
  loop do
     guard = place(cover,start)
     guards += 1
     start = guard + 1
     range = see(guard)
     cover = range.max + 1
     p [guard,cover,range]
     break unless cover < $n
  end
  
  #p see(5) if c == 3
  p $cars
  out.puts guards
  rescue
    out.puts 1
  end
end
