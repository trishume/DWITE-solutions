debug = false

input = debug ? STDIN : File.new("DATA1.txt","r")
out = debug ? STDOUT : File.open("OUT1.txt", 'w')

#tsetnoc siht ni snoitseuq 567 era ereht

5.times do
  line = input.gets
  reversed = line.reverse
  
  toks = reversed.split(" ")
  results = []
  
  toks.each do |t|
    res = t
    if (t =~ /^[0-9]+$/) != nil
      res = t.reverse
    end
    results << res
  end
  
  out.puts results.join(" ")
end