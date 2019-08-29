# frozen_string_literal: true

# Start game player has a name and an initial bankroll
# Player can go to different games via menu
# Slots
# High / Low
# Player places bet and wins / loses (hint: rand)
# Player's bankroll goes up and down with wins and losses

require_relative 'anscii_art'
require_relative 'gambler'
require_relative 'slots'
require_relative 'instructions'
require_relative 'roulette'
require_relative 'string'

def intro
  puts 'As you enter the casino you are greeted by the doorsman.'
  puts '"May I see some Identification please?"'
  print 'Enter your name: '
  name = gets.strip.capitalize
  validate_age
  if @age < 21
    puts 'Sorry, but you must be 21 or older to enter.'
    exit
  else
    AnsciiArt.intro_art
    puts "Welcome to the ruby casino, #{name}!"
    @gambler = Gambler.new(name, @age)
  end
end

def validate_age
  print 'Enter your age: '
  input = gets.chomp
  pattern = /[0-9]|[0-9][0-9]/
  valid_age = pattern.match?(input)
  # if age is valid and is a number @age = input to int. Otherwise validate age
  valid_age ? (input.is_valid_number? ? @age = input.to_i : validate_age) : validate_age
end

def main_menu
  puts 'what would you like to do?'
  puts "1) Play games\n2) Check wallet\n3) Add money\n4) Exit"
  print '> '
  choice = gets.to_i
  player_menu_selection(choice)
end

def player_menu_selection(choice)
  case choice
  when 1
    @gambler.out_of_money? ? (puts 'You dont have any money left!') : game_menu
  when 2
    @gambler.check_wallet
  when 3
    @gambler.add_funds
  when 4
    goodbye
  else
    puts 'Invalid selection!'
    main_menu
  end
end

def game_menu
  puts 'Which game would you like to play?'
  list_games
  print '> '
  choice = gets.to_i
  player_game_selection(choice)
end

def list_games
  puts "1) Slots\n2) Roulette"
end

def player_game_selection(choice)
  case choice
  when 1
    @gambler.out_of_money? ? (puts 'You dont have any money left!') : play_slots
  when 2
    @gambler.out_of_money? ? (puts 'You dont have any money left!') : play_roulette
  else
    puts 'Invalid selection'
  end
end

def play_slots
  AnsciiArt.slots_art
  puts 'Thanks for choosing the slots! Each spin is $1.'
  puts 'Get three matching values to win.'
  slot = Slots.new('slot machine', 15)
  puts "You currently have: $#{@gambler.money -= 1}"
  slot.spin
  if slot.win
    @gambler.money += slot.jackpot
    puts "You currently have: $#{@gambler.money}"
  end
  @gambler.out_of_money? ? (puts 'You dont have any money left!') :
                            ask_to_play_again('slots')
end

def ask_to_play_again(game)
  puts "\nPlay again?"
  print '> '
  input = gets.strip
  if input.is_y_or_n?
    case game
    when 'slots'
      input.downcase == 'y' ? play_slots : main_menu
    when 'roulette'
      input.downcase == 'y' ? play_roulette : main_menu
    end
  else
    ask_to_play_again(game)
  end
end

def play_roulette
  puts 'Thanks for choosing Roulette!'
  print 'Would you like to view the instructions(Y/N)? '
  input = gets.chomp
  puts "\n"
  Instructions.roulette if input.downcase == 'y'
  get_bets
  game = Roulette.new(@roulette_bet,
                      @player_numbers,
                      @player_zone,
                      @even_or_odd,
                      @player_color)
  game.spin_wheel
  evaluate_winnings(game)
  puts "money after winnings is #{@gambler.money}"
  @gambler.out_of_money? ? (puts 'You dont have any money left!') :
                            ask_to_play_again('roulette')
end

def get_bets
  set_bet_amount
  place_table_bet
  place_color_bet
  place_even_odd_bet
  place_zone_bet
end

def set_bet_amount
  print 'How much would you like to bet? '
  input = gets.chomp
  input.is_valid_number? ? (@roulette_bet = input.to_i) : set_bet_amount
end

def place_table_bet
  print 'Would you like to place a number bet for table numbers(Y/N)? '
  input = gets.chomp
  # if input is either 'y' or 'n',
  # check if input is 'y.' If so, call select_table_numbers.
  # If not, set @player_numbers = nil
  # otherwise recursive call place_table_bet
  input.is_y_or_n? ? (input.downcase == 'y' ? select_table_numbers :
                            @player_numbers = nil) :
                            place_table_bet
end

def place_color_bet
  print 'Would you like to place a number bet for a certain color(Y/N)? '
  input = gets.chomp
  input.is_y_or_n? ? (input.downcase == 'y' ? bet_on_colors :
                            @player_color = nil) :
                            place_color_bet
end

def place_even_odd_bet
  print 'Would you like to place a number bet for even or odd(Y/N)? '
  input = gets.chomp
  input.is_y_or_n? ? (input.downcase == 'y' ? even_or_odd :
                            @even_or_odd = nil) :
                            place_even_odd_bet
end

def place_zone_bet
  print 'Would you like to place a number bet for a certain zone(Y/N)? '
  input = gets.chomp
  input.is_y_or_n? ? (input.downcase == 'y' ? zone :
                            @player_zone = nil) :
                            place_zone_bet
end

def select_table_numbers
  @player_numbers = []
  puts 'Enter 6 numbers you would like to bet on: '
  until @player_numbers.size == 6
    print '> '
    input = gets.chomp
    pattern = /^[0-9]$|^[1-2][0-9]$|^3[0-6]$/
    pattern.match?(input) ? @player_numbers << input : select_table_numbers
  end
end

def bet_on_colors
  print 'Please type a color (red, green, or black): '
  input = gets.chomp.downcase
  pattern = /black|red|green/
  valid = pattern.match?(input) ? (@player_numbers = input) : false
  bet_on_colors unless valid
end

def zone
  puts "Zones are: \n1) 1-12\n2) 13-22\n3) 23-34"
  print 'Which zone would you like to bet on?(1, 2, or 3): '
  input = gets.chomp
  pattern = /[1-3]/
  valid = pattern.match?(input) ? (@player_zone = input) : false
  zone unless valid
end

def even_or_odd
  print 'Even or odd? '
  input = gets.chomp.downcase
  pattern = /even|odd/
  valid = pattern.match?(input) ? (@even_or_odd = input) : false
  even_or_odd unless valid
end

def evaluate_winnings(game)
  unless @player_numbers.nil?
    game.table_win ? (@gambler.money += (game.bet * 35)) :
                     (@gambler.money -= game.bet)
  end
  unless @player_zone.nil?
    game.zone_win ? (@gambler.money += game.bet) :
                    (@gambler.money -= game.bet)
  end
  unless @even_or_odd.nil?
    game.even_odd_win ? (@gambler.money += game.bet) :
                        (@gambler.money -= game.bet)
  end
  unless @player_color.nil?
    game.color_win ? (@gambler.money += game.bet) :
                     (@gambler.money -= game.bet)
  end
end

def goodbye
  puts 'Goodbye!'
  exit
end

intro
loop do
  main_menu
end
