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
    puts "\n*** RUBY CASINO ***\n".colorize(:green)
    @player = Player.new
    @player_arr << @player
    menu
  end

  def menu
    puts "\n---- CASINO GAMES ----".colorize(:green)
    games = "\n1) Roulette\n2) Slots\n3) Highlow\n4) Feelin Lucky?\n5) ATM\n6) View Players\n7) Cashout and Go Home"
    puts games
    puts "\nWhere would you like to go?".colorize(:light_blue)
    picked_game = user_input.downcase

    case picked_game
      when 'roulette', '1'
        Roulette.new(@player, self)
      when 'slots', '2'
        Slots.new(@player, self)
      when 'highlow', '3'
        Highlow.new(@player, self)
      when 'feelin', 'lucky', 'feelin lucky', '4'
        feelin_lucky
      when 'atm', '5'
        atm
      when 'view', 'players', 'view players', '6'
        player_menu
      when 'cashout', 'exit', 'go', 'home', 'go home', '7'
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
          puts "\nYou are now #{player.name.capitalize}!".colorize(:yellow); sleep 2
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
        puts "\nYou are now #{player.name.capitalize}!".colorize(:yellow); sleep 2
        player_menu
      else
        player_menu
      end
  end

  def feelin_lucky
    puts "\nLet's see how lucky you really are!".colorize(:light_blue); sleep 2
    @lucky_roll = 1 + rand(6)
    print "\nThe dice drops: "; sleep 2
    puts "#{@lucky_roll}"
    if @lucky_roll % 2 == 0
      puts "\nIt's your lucky day! You just won $500!".colorize(:green); sleep 2
      player.bank_roll = player.bank_roll + 500
      puts "You have $#{player.bank_roll} left.".colorize(:yellow); sleep 3
      menu
    else
      puts "\nSorry buddy, today's not your lucky day! You just lost $100. :(".colorize(:red); sleep 2
      player.bank_roll = player.bank_roll - 100
      puts "\nYou have $#{player.bank_roll}!".colorize(:yellow); sleep 3
      menu
    end
  end

  def atm
    puts "\nHow much money do you want to take out?".colorize(:light_blue)
    money = user_input.to_i
    if money > 500
      puts "\nYou can only take out $500 at a time.".colorize(:red)
      atm
    end
    player.bank_roll = player.bank_roll + money
    puts "\nPlease wait while we process your transaction...".colorize(:yellow); sleep 2
    puts "\nYour transaction was successfull.".colorize(:green)
    puts "\nYou now have $#{player.bank_roll}".colorize(:light_blue); sleep 3
    menu
  end

  def user_input
    print '> '
    gets.strip
  end
end

Casino.new
