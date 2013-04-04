debug = false

input = debug ? STDIN : File.new("DATA4.txt","r")
out = debug ? STDOUT : File.open("OUT4.txt", 'w')

require "pp"

def fill(row,col,mat)
  (-1..1).each do |dr|
    (-1..1).each do |dc|
      next if dr == 0 && dc == 0
      r,c = row+dr,col+dc
      mat[r][c] = 'F' unless mat[r][c] == '#'
    end
  end
end

def is_corner(r,c,mat)
  [-1,1].each do |dr|
    [-1,1].each do |dc|
      if mat[r+dr][c] == 'F' && mat[r][c+dc] == 'F' && mat[r+dr][c+dc] != 'F'
        return true
      end
    end
  end
  return false
end

def omit(row,col,mat)
  count = 0
  [[-1,0],[1,0],[0,-1],[0,1]].each do |pair|
    dr,dc = *pair
    count += 1 if mat[row+dr][col+dc] == '#'
  end
  if count >= 2 && !is_corner(row,col,mat)
    mat[row][col] = '.'
  end
end

def fill_all(mat)
  n = mat.size
  n.times do |row|
    n.times do |col|
      fill(row,col,mat) if mat[row][col] == '#'
    end
  end
end

def count_all(mat)
  n = mat.size
  count = 0
  n.times do |row|
    n.times do |col|
      count += 1 if mat[row][col] == 'F'
    end
  end
  count
end

def omit_all(mat)
  n = mat.size
  (n-2).times do |row|
    (n-2).times do |col|
      omit(row+1,col+1,mat) if mat[row+1][col+1] == 'F'
    end
  end
end

def p_grid(mat)
  mat.each do |row|
    puts row.join
  end
end

5.times do |i|
  n = input.gets.to_i
  grid = []
  grid << ['.'] * (n+2)
  n.times do |r|
    grid << ['.'] + input.gets.chomp.chars.to_a + ['.']
  end
  grid << ['.'] * (n+2)
  fill_all(grid)
  omit_all(grid)
  #puts
  #p_grid grid
  out.puts count_all(grid)
end
