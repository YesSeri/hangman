array = []
File.readlines('dict/dict').each do |line|
  array << line
end
new_arr = []
File.open('dict/new', 'w+') do |f|
  array.each do |el|  
    if (el.length-1>4 && el.length-1<13)
      f.puts el
      new_arr << el 
    end
  end
end
puts new_arr.reverse
