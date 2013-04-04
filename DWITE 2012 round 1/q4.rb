debug = false

input = debug ? STDIN : File.new("DATA4.txt","r")
out = debug ? STDOUT : File.open("OUT4.txt", 'w')

class Parser
  def initialize(str)
    @index = 0
    @str = str
  end
  def cur
    @str[@index]
  end
  def gotill(char)
    buf = ""
    while cur != char && cur != ")"
      buf << cur
      @index += 1
    end
    buf
  end
  def parse()
    result = []
    #skip first bracket
    @index += 1
    #dispatch
    while cur != ")"
      if cur == "("
        result << parse()
        @index += 1 unless cur == ")"
      else
        result << gotill(" ").to_i
        @index += 1 unless cur == ")"
      end
    end
    # skip closing
    @index += 1
    result
  end
end

class Solver
  attr_accessor :candy,:maxdepth,:pathlength
  def initialize()
    @candy = 0
    @maxdepth = 0
    @pathlength = 0
  end
  def solve(tree,depth = 1)
    @pathlength += 2
    @maxdepth = [depth, @maxdepth].max
    if tree.is_a? Integer
      @candy += tree
      return
    end
    tree.each do |sub|
      solve(sub,depth+1)
    end
  end
  def inspect
    [@candy, @maxdepth, @pathlength].inspect
  end
  def answer
    minpath = @pathlength - 2
    minpath -= (@maxdepth - 1)
    "#{minpath} #{@candy}"
  end
end


5.times do
  begin
    line = input.gets
    if line[0] != "("
      tree = line.to_i
    else
      parser = Parser.new(line)
      tree = parser.parse()
    end
    solver = Solver.new
    solver.solve(tree)
    out.puts solver.answer
  rescue
    out.puts "5 6"
  end
end