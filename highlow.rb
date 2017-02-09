class Highlow
  attr_accessor :player, :casino

  def initialize(player, casino)
    @player = player
    @casino = casino
    puts """
   ____    ____    ____    ____
  |A   |  |K   |  |Q   |  |J   |
  |(\\/)|  | /\\ |  | /\\ |  | &  |
  | \\/ |  | \\/ |  |(__)|  |&|& |
  |   A|  |   K|  | /\\Q|  | | J|
  `----`  `----'  `----'  `----'"""
    puts "\nWelcome to High-Low #{player.name}!".colorize(:light_blue); sleep 1.5
    puts "\nYou have $#{player.bank_roll} to play with.".colorize(:green); sleep 2
    highlow_menu
  end

  def highlow_menu
    puts "\n---- HIGHLOW ----".colorize(:green)
    puts "1) Play"
    puts "2) Learn The Rules"
    puts "3) Cashouts And Return To The Casino"
    puts "\nPlease pick an option. (1-3)".colorize(:light_blue)

    case @casino.user_input
      when '1', 'play'
        highlow_bet
      when '2'
        highlow_rules
      when '3'
        puts "\nYou have $#{player.bank_roll}.".colorize(:yellow)
        puts "\nThanks for playing Highlow #{player.name}! Have a good day!".colorize(:green); sleep 3
        @casino.menu
      else
        puts "\nPlease pick a valid option from the menu.".colorize(:red); sleep 2
        highlow_menu
    end
  end

  def highlow_bet
    puts "\nHow much do you want to bet #{player.name}?".colorize(:light_blue)
    @player_bet = @casino.user_input.to_i
    if @player_bet == 0
      puts "\nYou have to make a bet if you want to play!".colorize(:red); sleep 1.5
      highlow_bet
    elsif @player_bet > player.bank_roll
      puts "\nGiant Black Security Guard: 'GET THE HELL OUTTA HERE!'".colorize(:red); sleep 1.5
      puts "\nYou've been kicked out of the casino. Sucks to suck!".colorize(:yellow)
      exit
    else
      puts "\nOk, your bet is for $#{@player_bet}. Are you ready to play? (yes/no)".colorize(:light_blue)
      if @casino.user_input == 'yes'
        play_game
      else
        puts "\nCome back when you're ready to play!".colorize(:red); sleep 2
        highlow_menu
      end
    end
  end

  def play_game
    @dealer_card = rand(1..14)
    @player_card = rand(1..14)
    puts "\nDealer flips a #{@dealer_card}.".colorize(:yellow); sleep 2
    puts "\nYour card is a #{@player_card}.".colorize(:light_blue); sleep 2
    if @dealer_card > @player_card
      puts "\nSorry, the Dealer wins!".colorize(:red); sleep 2
      lose
    elsif @dealer_card == @player_card
      puts "\nPUSH!".colorize(:yellow)
      play_again
    else
      puts "\nCongrats! You Win!".colorize(:green); sleep 2
      win
    end
  end

  def play_again
    puts "\nDo you want to play again #{player.name}? (yes/no)".colorize(:light_blue)
    if @casino.user_input == 'yes'
      highlow_bet
    else
      puts "Thank you for playing #{player.name}! Come back soon!".colorize(:green); sleep 3
      @casino.menu
    end
  end

  def win
    player.bank_roll = player.bank_roll + (@player_bet * 2)
    puts "\nYou now have $#{player.bank_roll}".colorize(:light_blue)
    play_again
  end

  def lose
    player.bank_roll = player.bank_roll - @player_bet
    puts "\nYou now have $#{player.bank_roll}".colorize(:yellow)
    play_again
  end

  def highlow_rules
    puts "\n---- Rules of High-Low ----\n".colorize(:green)
		puts "1) Player places a bet of his/her choosing."
		puts "2) Dealer shows the card from the top of the deck as his/her card."
		puts "3) Dealer shows the next card from the deck as player's card."
		puts "4) Whoever has the higher numbered card wins."
		puts "5) It's as simple as that!"
		puts "6) Type 'back' to return to the menu".colorize(:yellow)
		if @casino.user_input.downcase == 'back'
			highlow_menu
    else
      puts "\nMake sure you spell 'back' correctly!".colorize(:red); sleep 2
      highlow_rules
		end
  end
end
