debug = false

input = File.new("DATA3.txt","r")
$out = File.open("OUT3.txt", 'w')

class Float
  def precision(pre)
    mult = 10 ** pre
    (self * mult).round.to_f / mult
  end
end

class Vec
  attr_accessor :x,:y
  @x = 0
  @y = 0
  def initialize(txt)
      nums = txt.split(" ")
      @x = nums[0].to_i
      @y = nums[1].to_i
  end
end

def dist(a, b)
    return Math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y))
end

def area(a, b, c)
    v = 0
    v += a.x * b.y - b.x * a.y
    v += b.x * c.y - c.x * b.y
    v += c.x * a.y - a.x * c.y
    return (v / 2).abs
end

def minlength(a, b, c)
    ab = dist(a, b);
    ac = dist(a, c);
    bc = dist(b, c);
    if (ab * ab + bc * bc < ac * ac)
        return bc
    end
    if (ab * ab + ac * ac < bc * bc)
        return ac
    end
    return area(a, b, c) * 2 / ab
end
def solve(points, store)
    best = 9999999999999.0;
    (points.size - 1).times do |i|
        best = [best, minlength(points[i], points[i + 1], store)].min
    end
    $out.puts "%0.02f" % best
end

5.times do
    begin   
      points = input.gets.to_i
      p = []
      points.times do
          line = input.gets
          p << Vec.new(line)
      end
      solve(p, Vec.new(input.gets))
    rescue Exception => e
      $out.puts "0.00"
    end
end
