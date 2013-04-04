debug = false

input = debug ? STDIN : File.new("DATA5.txt","r")
output = debug ? STDOUT : File.open("OUT5.txt", 'w')

def tokenize_string( string )
  string = string.gsub("(", " ( ")
  string = string.gsub(")", " ) ")
  string = string.gsub("~", " ~ ")
  token_array = string.split(" ")
  return token_array
end

# A helper method to take care of the repetitive stuff for us
def is_match?( string, pattern)
  match = string.match(pattern)
  return false unless match
  # Make sure that the matched pattern consumes the entire token
  match[0].length == string.length
end

# Detect a symbol
def is_symbol?( string )
  # Anything other than parentheses, single or double quote and commas
  return is_match?( string, /[^\"\'\,\(\)]+/ ) 
end

def convert_tokens( token_array )
  converted_tokens = []
  token_array.each do |t|
    converted_tokens << "(" and next if( t == "(" )
    converted_tokens << ")" and next if( t == ")" )
    converted_tokens << t.to_sym and next if( is_symbol?(t) )
    # If we haven't recognized the token by now we need to raise
    # an exception as there are no more rules left to check against!
    raise Exception, "Unrecognized token: #{t}"
  end
  return converted_tokens
end

def re_structure( token_array, offset = 0 )
  struct = []
  while( offset < token_array.length )
    if(token_array[offset] == "(")
      # Multiple assignment from the array that re_structure() returns
      offset, tmp_array = re_structure(token_array, offset + 1)
      struct << tmp_array
    elsif(token_array[offset] == ")")
      break
    else
      struct << token_array[offset]
    end
    offset += 1
  end
  return [offset, struct]
end

def post_process(tree_arr)
  tree = tree_arr.clone
  for i in 0..(tree.length)
    if tree[i] == :~
      sub = tree[i+1].kind_of?(Array) ? post_process(tree[i+1]) : tree[i+1]
      tree[i] = [:~,sub]
      tree.delete_at(i+1)
      i -= 1
    elsif tree[i].kind_of?(Array)
      tree[i] = post_process(tree[i])
    end
  end
  return tree
end

def parse( string )
  token_array = tokenize_string( string )
  token_array = convert_tokens( token_array )
  s_expression = re_structure( token_array )[1]
  return post_process(s_expression)
end

def self_notted(first,second)
  if second.kind_of?(Array) && second.length == 2 # is second a not
    return second[1] == first
  end
  return false
end

# returns 0 for false 1 for true and an array or symbol for whatever
def simplify(node)
  return node if node.kind_of?(Symbol)
  # must be an array
  tree = node.clone
  case tree.length
  when 0
    return 0
  when 1
    return simplify(tree[0])
  when 2  # NOT/~
    sub = simplify(tree[1])
    case sub
    when 0
      return 1
    when 1
      return 0
    else
      return [:~,sub]
    end
  else
    lhs = simplify(tree[0])
    rhs = simplify(tree[2])
    selfnot = self_notted(lhs,rhs) || self_notted(rhs,lhs)
    if tree[1] == :^ # AND
      return 0 if lhs == 0 || rhs == 0
      if selfnot
        return 0
      else
        return [lhs,tree[1],rhs]
      end
    else #OR
      return 1 if lhs == 1 || rhs == 1
      if selfnot
        return 1
      else
        return [lhs,tree[1],rhs]
      end
    end
  end
  raise "This Should Not Happen!"
end

5.times do
  3.times do |i|
    expr = input.gets
    output.print simplify(parse(expr)) == 1 ? "Y" : "N"
  end
  output.puts ""
end