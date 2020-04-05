require 'yaml'
class Hangman
  MAX_TRIES = 10
  SAVE_WORD = "SAVE"
  def initialize
    game_reset
  end
  def game_reset
    @tries = 1
    @guess_arr = []
    @answer = random_line
    game_play
  end
    def game_play
    gameover=false
    while (!gameover)
      round()
      gameover = gameover?
    end
    game_reset if play_again?
  end
  def round
    show_turns
    show_progress
    @guess_arr << guess
    @tries += 1 if false_guess?
  end
  def false_guess?
    @answer.chars.each do |a|
      if @guess_arr[-1] == a
        return false 
      end
    end
    if @guess_arr[-1] == SAVE_WORD
      return false
    end
    true
  end
  def play_again?
    puts "Play again?"
    input = gets.chomp
    return false if input[0] == "n"
    true
  end
  def show_turns
    puts "#{@tries} / #{MAX_TRIES}"
  end
  def gameover?
    if @guess_arr[-1] == SAVE_WORD
      save
      puts "Game saved."
      return true
    elsif ((@answer.chars-@guess_arr).empty?)
      puts @answer
      puts "Game WON!"
      return true
    elsif (@tries==MAX_TRIES)
      puts @answer
      puts "Game lost."
      return true
    else 
      return false
    end
  end
  def show_progress
    @answer.chars.each do |a| #getting #f a b d g
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

  def guess
    print "   "
    input = gets.chomp.upcase
    if input == SAVE_WORD
      input 
    else
      input[0]
    end
  end

  def random_line
    File.readlines("dict/new-dict").sample.gsub("\n", "").upcase
  end
  def save
    Dir.mkdir('save') unless File.exists?('save')
    File.open('save/save.yml', 'w') {|f| f.write(YAML.dump(self))}
  end
end
class Game
  def initialize
    greeting
    mode
  end
  def mode
    puts "Enter play start, write load to return to earlier game. Enter save, if you ever wish to leave."
#    begin
#      retries ||= 0
      input = gets.chomp
      if input[0].upcase == "L"
        puts "loading"
        hangman = load
        hangman.game_play
      else
        puts "playing"
        hangman = Hangman.new
      end
#      raise 'An error has occured'  
#    rescue
    puts "Enter valid input"
#      retry if (retries +=1) <3
#    end
  end
  def load
    YAML.load(File.read('save/save.yml'))
  end
  def greeting
    puts "welcome"
  end
end
Game.new
