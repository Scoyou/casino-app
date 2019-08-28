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

def intro
  puts 'As you enter the casino you are greeted by the doorsman.'
  puts '"May I see some Identification please?"'
  print 'Enter your name: '
  name = gets.strip.capitalize
  print 'Enter your age: '
  age = gets.to_i
  if age < 21
    puts 'Sorry, but you must be 21 or older to enter.'
    exit
  else
    AnsciiArt.intro_art
    puts "Welcome to the ruby casino, #{name}!"
    @gambler = Gambler.new(name, age)
  end
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
    game_menu
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
    play_slots
  when 2
    play_roulette
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
  puts "\nSpin again?"
  print '> '
  input = gets.strip
  input.downcase == 'y' ? play_slots : main_menu
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
  puts "\nPlay again?"
  print '> '
  input = gets.strip
  input.downcase == 'y' ? play_roulette : main_menu
end

def get_bets
  print 'How much would you like to bet? '
  @roulette_bet = gets.to_i
  place_table_bet
  place_number_bet
  place_even_odd_bet
  place_zone_bet
end

def place_table_bet
  print 'Would you like to place a number bet for table numbers(Y/N)? '
  input = gets.chomp
  if yes_no_validator(input)
    selection = input
    input.downcase == 'y' ? select_table_numbers : @player_numbers = nil
  else
    place_table_bet
  end
end

def place_number_bet
  print 'Would you like to place a number bet for a certain color(Y/N)? '
  input = gets.chomp
  if yes_no_validator(input)
    selection = input
    input.downcase == 'y' ? bet_on_colors : @player_color = nil
  else
    place_number_bet
  end
end

def place_even_odd_bet
  print 'Would you like to place a number bet for even or odd(Y/N)? '
  input = gets.chomp
  if yes_no_validator(input)
    selection = input
    input.downcase == 'y' ? even_or_odd : @even_or_odd = nil
  else
    place_even_odd_bet
  end
end

def place_zone_bet
  print 'Would you like to place a number bet for a certain zone(Y/N)? '
  input = gets.chomp
  if yes_no_validator(input)
    selection = input
    input.downcase == 'y' ? zone : @player_zone = nil
  else
    place_zone_bet
  end
end

def select_table_numbers
  @player_numbers = []
  puts 'Enter 6 numbers you would like to bet on: '
  print '> '
  selection = gets.chomp
  until @player_numbers.size == 5
    print '> '
    is_valid_number?(selection) ? (@player_numbers << gets.to_i) :
                                   select_table_numbers
  end
end

def bet_on_colors
  puts 'Please type a color (red, green, or black):'
  @player_color = gets.chomp
end

def zone
  puts 'Which zone are you betting on?(1, 2, or 3):'
  @player_zone = gets.to_i
end

def even_or_odd
  print 'Even or odd? '
  @even_or_odd = gets.chomp.downcase
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

def is_valid_number?(input)
  pattern = /^\d*\.?\d+$/
  if pattern.match?(input)
    return true
  else
    puts "#{input} is not a valid selection."
    return false
  end
end

def yes_no_validator(input)
  pattern = /y|n/
  if pattern.match?(input)
    return true
  else
    puts "#{input} is not a valid selection."
    return false
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
