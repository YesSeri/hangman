require 'yaml'
class Hangman
  MAX_TURNS = 10
  def initialize
    game_reset
  end
  def game_reset
    @turn = 1
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
  end
  def round
    show_turns
    @turn += 1
    show_progress
    @guess_arr << guess
  end
  def show_turns
    puts "#{@turn} / #{MAX_TURNS}"
  end
  def gameover?
    if @guess_arr[-1] == 'save'
      save
      puts "Game saved, goodbye"
      return true
    elsif (@turn==MAX_TURNS)
      puts "Game lost, play again?"
      return true
    elsif ((@answer.chars-@guess_arr).empty?)
      puts "Game WON! Play again"
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
    puts "Input a single character as a guess."
    input = gets.chomp.upcase
    input 
  end

  def random_line
    File.readlines("dict/short-dict").sample.gsub("\n", "").upcase
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
    puts "press enter to play, write load to load earlier game. Enter save, if you ever wish to leave."
    input = gets.chomp
    if input[0].downcase == "l"
      puts "loading"
    else
      hangman = Hangman.new
    end
  end
  def load
  end
  def greeting
    puts "welcome"
  end
end
Game.new
