debug = false

input = debug ? STDIN : File.new("DATA5.txt","r")
out = debug ? STDOUT : File.open("OUT5.txt", 'w')

def fac(n)
  return 1 if n <= 0
  (1..n).inject(:*)
end

def choose(n,k)
  return 0 if k > n
  fac(n)/(fac(k)*fac(n-k))
end

def t(n)
  return 56 if n == 1
  y =  (fac(5)/fac(5-n)) + 3*(n-1) + (fac(7)/fac(7-n)) + (n-1)
  t(n-1) + 4*y + choose(8,n-1)*(9-n)
end

5.times do |i|
  n = input.gets.to_i
  out.puts t(n)
end
