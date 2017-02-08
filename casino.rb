require 'colorize'
require 'pry'
require_relative 'player'
require_relative 'roulette'
require_relative 'slots'
require_relative 'highlow'

class Casino
  attr_accessor :player, :bank_roll

  def initialize
    @player_arr = []
    puts "*** RUBY CASINO ***\n".colorize(:green)
    @player = Player.new
    @player_arr << @player
    menu
  end

  def menu
    puts "\n---- CASINO GAMES ----".colorize(:green)
    games = "\nRoulette\nSlots\nHighlow\nATM\nView Players\nCashout and Go Home"
    puts games
    puts "\nWhere would you like to go?".colorize(:light_blue)
    picked_game = user_input.downcase

    case picked_game
      when 'roulette'
        Roulette.new(@player, self)
      when 'slots'
        Slots.new(@player, self)
      when 'highlow'
        Highlow.new(@player, self)
      when 'atm'
        atm
      when 'view', 'players', 'view players'
        player_menu
      when 'cashout', 'exit', 'go', 'home', 'go home'
        total = player.bank_roll
        puts "\nHere is your money: $#{total}".colorize(:green)
        puts "\nThank you for playing. Come back soon!".colorize(:light_blue)
        exit
      else
        puts "Please select from the choices above.".colorize(:red)
        menu
    end
  end

  def player_menu
    puts "\n---- PLAYERS ----".colorize(:green)
    puts '1) View Players'
    puts '2) Add A Player'
    puts '3) Return To Casino'
    puts "\nPlease pick an option (1-3)".colorize(:light_blue)
    user_move = user_input

    case user_move
      when '1'
        player_profile
      when '2'
        if @player_arr.count < 4
          @player = Player.new
          @player_arr << @player
          puts "\nYou are now #{player.name.capitalize}!".colorize(:green)
        else
          puts "Sorry, only 4 players allowed!"
        end
        player_menu
      when '3'
        menu
      else
        puts "\nInvalid option. Please pick again".colorize(:red)
        player_menu
    end
  end

  def player_profile
    @player_arr.each_with_index { |x, i| puts "#{i + 1}. #{x.name.capitalize} $#{x.bank_roll}" }
    puts "\nWould you like to switch players? (yes/no)".colorize(:light_blue)
    if user_input == 'yes'
      puts "\nWhich player would you like to play as?".colorize(:light_blue)
      player_switch = user_input

      case player_switch
      when '1'
          @player = @player_arr[0]
        when '2'
          @player = @player_arr[1]
        when '3'
          @player = @player_arr[2]
        when '4'
          @player = @player_arr[3]
        else
          puts "Player does not exist".colorize(:red)
          player_menu
        end
        puts "\nYou are now #{player.name.capitalize}!".colorize(:green)
        player_menu
      else
        player_menu
      end
  end

  def atm
    puts "\nHow much money do you want to take out?".colorize(:light_blue)
    money = user_input.to_i
    if money > 500
      puts "You can only take out $500 at a time.".colorize(:red)
      atm
    end
    player.bank_roll = player.bank_roll + money
    puts "Please wait while we process your card...".colorize(:yellow)
    puts "Your transaction was successfull.".colorize(:green)
    puts "You now have $#{player.bank_roll}".colorize(:light_blue)
    menu
  end

  def user_input
    print '> '
    gets.strip
  end
end

Casino.new
