class Hangman
  def initialize 
    @answer = "getting"
    @guess_arr = ["a","d","f","g","b", "e", "t", "i"]
    progress()
  end
  def progress
    puts @answer
    puts @answer.length
    arr =  @answer.chars
    arr.each do |a| #getting #f a b d g
      printed_char = false
      @guess_arr.each do |b|
        if a == b
	  printed_char = true
          print a
          break
        end
      end
      if printed_char == false
        print "_"
      end
    end
  end
end
array = ["g","e","t","i","n","g","b"]
print array
puts
answer = "getting".chars
print answer
puts
puts "#{(answer-array).empty?}"
puts "#{(answer-array)}"
