class Slots
  attr_accessor :player, :casino

  def initialize(player, casino)
    @player = player
    @casino = casino
    puts """
                       |Jackpot|
           ____________|_______|____________
          |  __    __    ___  _____   __    |
          | / _\  / /   /___\/__   \ / _\   |
          | \ \  / /   //  //  / /\ \\ \  25|
          | _\ \/ /___/ \_//  / /  \/_\ \ []|
          | \__/\____/\___/   \/     \__/ []|
          |===_______===_______===_______===|
          ||*|\_     |*| _____ |*|\_     |*||
          ||*|| \ _  |*||     ||*|| \ _  |*||
          ||*| \_(_) |*||*BAR*||*| \_(_) |*||
          ||*| (_)   |*||_____||*| (_)   |*|| __
          ||*|_______|*|_______|*|_______|*||(__)
          |===_______===_______===_______===| ||
          ||*| _____ |*|\_     |*|  ___  |*|| ||
          ||*||     ||*|| \ _  |*| |_  | |*|| ||
          ||*||*BAR*||*| \_(_) |*|  / /  |*|| ||
          ||*||_____||*| (_)   |*| /_/   |*|| ||
          ||*|_______|*|_______|*|_______|*||_//
          |===_______===_______===_______===|_/
          ||*|  ___  |*|   |   |*| _____ |*||
          ||*| |_  | |*|  / \  |*||     ||*||
          ||*|  / /  |*| /_ _\ |*||*BAR*||*||
          ||*| /_/   |*|   O   |*||_____||*||
          ||*|_______|*|_______|*|_______|*||
          |lc=___________________________===|
          |  /___________________________\  |
          |   |                         |   |
         _|    \_______________________/    |_
        (_____________________________________)"""
    puts "\nWelcome to the Slot Machines #{player.name}!".colorize(:light_blue)
    puts "\nYou have $#{player.bank_roll} to play with.".colorize(:green)
    slot_menu
  end

  def slot_menu
    puts "\n---- SLOTS ----".colorize(:green)
    puts "1) Insert Bet"
    puts "2) Pull The Lever"
    puts "3) Cashout And Return To The Casino"
    puts "\nPick an option. (1-3)".colorize(:light_blue)

    case @casino.user_input
    when '1'
      insert_bet
    when '2'
      pull_lever
    when '3'
      puts "\nYou have $#{player.bank_roll}.".colorize(:yellow)
      puts "\nThank you for playing the Slots #{player.name}! Come again!".colorize(:green); sleep 3
      @casino.menu
    else
      puts "\nPlease pick a valid option.".colorize(:red); sleep 2
      slot_menu
    end
  end

  def insert_bet
    puts "\nHow much do you want to bet?".colorize(:light_blue)
    @player_bet = @casino.user_input.to_i
    if @player_bet == 0
      puts "\nYou can't spin without a bet!".colorize(:red)
      insert_bet
    elsif @player_bet > player.bank_roll
      puts "\nGiant Black Security Guard: 'GET THE HELL OUTTA HERE!'".colorize(:red)
      puts "\nYou've been kicked out of the casino. Sucks to Suck!".colorize(:yellow)
      exit
    else
      puts "\nYour Bet: $#{@player_bet}".colorize(:green); sleep 2
      slot_menu
    end
  end

  def pull_lever
    if @player_bet == nil
      puts "\nYou need to make a bet first #{player.name}!".colorize(:red); sleep 3
      slot_menu
    else
      slot1 = ["Basketball", "Football", "Baseball", "Volleyball", "Soccer"]
      slot2 = ["Basketball", "Football", "Baseball", "Volleyball", "Soccer"]
      slot3 = ["Basketball", "Football", "Baseball", "Volleyball", "Soccer"]
      shuffle_machine = []
      print "\nHere..."; sleep 1
      print "We..."; sleep 1
      puts "Go!"; sleep 1
      puts "\nSpinning...".colorize(:green); sleep 3
      option1 = slot1[rand(0..4)]
      shuffle_machine << option1
      option2 = slot2[rand(0..4)]
      shuffle_machine << option2
      option3 = slot3[rand(0..4)]
      shuffle_machine << option3
      print "\n#{shuffle_machine[0]} |".colorize(:yellow); sleep 1.5
      print " #{shuffle_machine[1]} |".colorize(:yellow); sleep 1.5
      puts " #{shuffle_machine[2]}".colorize(:yellow); sleep 1.5
      shuffle_machine = shuffle_machine.uniq
      shuffle_machine = shuffle_machine.count
      if shuffle_machine == 1
        jackpot
      elsif shuffle_machine == 2
        winnings
      else
        loser
      end
    end
  end

  def jackpot
    player.bank_roll = player.bank_roll + (@player_bet * 4)
    puts "\n*** JACKPOT ***".colorize(:green)
    puts "\nYou won $#{@playet_bet * 4}!! You now have $#{player.bank_roll}".colorize(:light_blue)
    play_again
  end

  def winnings
    player.bank_roll = player.bank_roll + (@player_bet * 1.5)
    puts "\nYou won $#{@player_bet * 1.5}!".colorize(:green)
    puts "\nYou now have $#{player.bank_roll}".colorize(:light_blue)
    play_again
  end

  def loser
    player.bank_roll = player.bank_roll - (@player_bet)
    puts "\nSorry, you lose!".colorize(:red)
    puts "\nYou now have $#{player.bank_roll}".colorize(:light_blue)
    play_again
  end

  def play_again
    puts "\nDo you want to play again #{player.name}? (yes/no)".colorize(:yellow)
    player_choice = @casino.user_input
    if player_choice == 'yes'
      slot_menu
    else
      puts "\nThanks for playing Slots! Come back soon!".colorize(:green); sleep 3
      @casino.menu
    end
  end
end
