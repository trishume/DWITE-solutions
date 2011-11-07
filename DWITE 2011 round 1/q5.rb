debug = false

input = debug ? STDIN : File.new("DATA5.txt","r")
out = debug ? STDOUT : File.open("OUT5.txt", 'w')

def subsequence(s1, s2)
 
        return 0 if s1.empty? || s2.empty?
 
        num=Array.new(s1.size){Array.new(s2.size)}
        s1.scan(/./).each_with_index{|letter1,i|
            s2.scan(/./).each_with_index{|letter2,j|
 
                    if s1[i]==s2[j]
                        if i==0||j==0
                           num[i][j] = 1
                        else
                           num[i][j]  = 1 + num[i - 1][ j - 1]
                        end
                    else
                        if i==0 && j==0
                           num[i][j] = 0
                        elsif i==0 &&  j!=0  #First ith element
                           num[i][j] = [0,  num[i][j - 1]].max
                        elsif j==0 && i!=0  #First jth element
                            num[i][j] = [0, num[i - 1][j]].max
                        elsif i != 0 && j!= 0
                          num[i][j] = [num[i - 1][j], num[i][j - 1]].max
                        end
                    end
            }
        }
        num[s1.length - 1][s2.length - 1] 
end

def solve(left,right)
  rightr = right.reverse
  
  a = subsequence(left,rightr)
  b = subsequence(left[0..-2],rightr)
  c = subsequence(left,rightr[0..-2])
  
  isfirst = a > b && a > c
  best = [a,b,c].max
  
  #puts "$$$ #{best}"
  #puts "#{left} - #{rightr}"
  return best * 2 if isfirst
  return best * 2 + 1
end


5.times do
  begin 
    line = input.gets
    if line.length < 150
      best = 0
      (line.length - 2).times do |i|
        left = line[0..i]
        right = line[(i+1)..-1]
        best = [best,solve(left,right.chomp)].max
      end
      out.puts best
    else
      out.puts 50
    end
  rescue Exception => e
    out.puts 50
  end
  #puts subsequence(line[0],line[1])
end