require 'colorize'

class Player
  attr_accessor :name, :bank_roll

  def initialize
    puts 'What is your name?'.colorize(:light_blue)
    @name = user_input
    if @name == ''
      puts "\nPlease type your name\n".colorize(:red)
      initialize
    else
      player_money
    end
  end

  def player_money
    puts "How much money are you willing to lose #{@name}?".colorize(:light_blue)
    @bank_roll = user_input.to_i
    if @bank_roll == 0
      puts "\nYou need money in order to do anything at a Casino!\n".colorize(:red)
      player_money
    else
      puts "\nYou have $#{@bank_roll}! Let's play!".colorize(:yellow); sleep 2
    end
  end

  def user_input
    print '> '
    gets.strip
  end
end
