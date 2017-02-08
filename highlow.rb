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
    puts "\nWelcome to High-Low #{player.name}!".colorize(:light_blue)
    puts "\nYou have #{player.bank_roll} to play with.".colorize(:green)
    highlow_welcome
  end

  def highlow_welcome

  end 
end
