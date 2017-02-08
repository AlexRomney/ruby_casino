class Roulette
  attr_accessor :player, :casino

  def initialize(player, casino)
    @player = player
    @casino = casino
    @roulette_colors = ["RED", "BLACK"]
    puts "\nWelcome to Roulette #{player.name}!".colorize(:light_blue)
    puts "\nYou have $#{player.bank_roll} to play with.\n".colorize(:green)
    roulette_menu
  end

  def roulette_menu
    puts """
    EVEN           (0)(00)

    1-18        | 1  2  3  4
                | 5  6  7  8    Block 1-12
                | 9 10 11 12  ________________
    RED         | 13 14 15 16
    BLACK       | 17 18 19 20   Block 13-24
                | 21 22 23 24 ________________
                | 25 26 27 28
          (0,00)| 29 30 31 32   Block 25-36
    19-36       | 33 34 35 36 ________________
                 _____________
    ODD
            col-1 | col-2 | col-3
  """
  puts "---- ROULETTE ----".colorize(:green)
  puts "1) Place A Bet"
  puts "2) Spin The Wheel"
  puts "3) Cashout And Return To Casino"
  puts "\nPlease pick an option. (1-3)".colorize(:light_blue)
  user_choice = user_input

  case user_choice
    when '1'
      roulette_bet
    when '2'
      roulette_spin
    when '3'
      cashout
    else
      puts "\nPlease pick a valid menu option.".colorize(:red)
      roulette_menu
    end
  end

  def roulette_bet
    puts "\nWhat number do you want to place your bet on? (1-36)".colorize(:light_blue)
    @number = user_input.to_i
    if @number <= 36 && @number != 0
      puts "\nHow much do you want to bet?".colorize(:light_blue)
      @number_bet = user_input.to_i
      if @number_bet == 0
        puts "\nYou can't play without a bet!".colorize(:red)
        roulette_bet
      elsif @number_bet <= @player.bank_roll
        puts "\nYou are betting $#{@number_bet} on #{@number}.".colorize(:yellow)
        roulette_color
      else
        puts "\nYou don't have enough money! Go to the ATM!".colorize(:red)
        @casino.menu
      end
    else
      puts "\nPlease pick a valid number.".colorize(:red)
      roulette_bet
    end
  end

  def roulette_color
    puts "\nWhat color do you want to bet on? (1-2)".colorize(:light_blue)
    puts "1) RED"
    puts "2) BLACK"
    @color = user_input.to_i

    case @color
    when 1
      @roulette_colors[@color - 1]
      roulette_color_bet
    when 2
      @roulette_colors[@color - 1]
      roulette_color_bet
    else
      puts "\nYou better hurry and pick a color before it's too late!".colorize(:red)
      roulette_color
    end
  end

  def roulette_color_bet
    puts "\nWhat do you want to bet?".colorize(:light_blue)
    @color_bet = user_input.to_i
    if @color_bet == 0
      puts "\nYou need to bet something!".colorize(:red)
      roulette_color_bet
    elsif @color_bet > @player.bank_roll - @number_bet
      puts "\nGiant Black Security Guard: 'GET THE HELL OUTTA HERE!'".colorize(:red)
      puts "\nYou've been kicked out of the casino for trying to make a bet you can't afford. Sucks to suck!".colorize(:yellow)
      exit
    else
      puts "\nYour Bet: $#{@number_bet} on #{@number} and $#{@color_bet} on #{@roulette_colors[@color - 1]}".colorize(:yellow)
      roulette_menu
    end
  end

  def roulette_spin
    if @number == nil
      puts "\nYou need to place your bets first!".colorize(:red)
      roulette_menu
    else
      puts "\nNo more bets!".colorize(:red)
      puts "\nYour Bets: #{@number} #{@roulette_colors[@color - 1]}".colorize(:yellow); sleep 2
      puts "\nSpinning..."; sleep 3
      @game_number = rand(1..36)
      @game_color = @roulette_colors.sample
      puts "\nDealer: #{@game_number} #{@game_color}!".colorize(:light_blue); sleep 1
      if @game_number == @number && @game_color == @roulette_colors[@color - 1]
        big_win
      elsif @game_color == @roulette_colors[@color - 1]
        color_win
      elsif @game_number == @number
        number_win
      else
        loser
      end
    end
  end

  def big_win
    player.bank_roll = player.bank_roll + (@color_bet * 2) + (@number_bet * 36)
    puts "\nYou Win!! You now have $#{player.bank_roll}".colorize(:green)
    play_again
  end

  def color_win
    player.bank_roll = player.bank_roll + (@color_bet * 2) - @number_bet
    puts "\nYou hit #{@game_color}! But you lost $#{@number_bet}! You now have $#{player.bank_roll}".colorize(:yellow)
    play_again
  end

  def number_win
    player.bank_roll = player.bank_roll + (@number_bet * 36) - @color_bet
    puts "\nYou hit #{@game_number}! But you lost $#{@color_bet}! You now have $#{player.bank_roll}".colorize(:yellow)
    play_again
  end

  def loser
    player.bank_roll = player.bank_roll - @number_bet - @color_bet
    puts "\nYou lost. You now have $#{player.bank_roll}".colorize(:red)
    play_again
  end

  def play_again
    puts "\nWant to play again? (yes/no)".colorize(:light_blue)
    if user_input == 'yes'
      roulette_menu
    else
      puts "\nThank you for playing! Come back soon #{player.name}!".colorize(:green)
      @casino.menu
    end
  end

  def cashout
    puts "\nYou have $#{player.bank_roll} left.".colorize(:light_blue)
    puts "\nHope you enjoyed your time here at Roulette! See you next time #{player.name}!".colorize(:green)
    @casino.menu
  end

  def user_input
    print '> '
    gets.strip
  end
end
