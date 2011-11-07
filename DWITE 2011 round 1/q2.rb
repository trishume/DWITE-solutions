debug = false

input = debug ? STDIN : File.new("DATA2.txt","r")
out = debug ? STDOUT : File.open("OUT2.txt", 'w')

#tsetnoc siht ni snoitseuq 567 era ereht

5.times do
  stacksnum = input.gets.to_i
  stacks = []
  
  stacksnum.times do
    stacks << input.gets.to_i
  end
  
  avg = stacks.inject(0) { |sum, el| sum + el } / stacks.size
  #puts avg
  moves = 0
  
  stacks.each do |s|
    if s > avg
      moves += s-avg
    end
  end
  
  out.puts moves
end