debug = false

input = debug ? STDIN : File.new("DATA3.txt","r")
output = debug ? STDOUT : File.open("OUT3.txt", 'w')

def good(arr)
  return false if arr.nil?
  return true if arr.length == 1
  first = arr[0]
  arr.each do |p|
    return false if p != first
  end
  return true
end

5.times do
  begin
  
    sizes = input.gets.split(" ").map {|x| x.to_i}
  
    recs = {}
  
    sizes[0].times do
      rec = input.gets.split(" ")
      pref = rec[2]
      prev = recs[rec[1]]
      ans = prev.nil? ? [pref] : (prev + [pref])
      recs[rec[1]] = ans
    end
  
    ded = 0
    sizes[1].times do
      rec = input.gets.split(" ")
      prefs = recs[rec[1]]
      ded += 1 if good(prefs)
    end
    output.puts ded
  rescue Exception => e
    output.puts 0
  end
end