# frozen_string_literal: true

# Start game player has a name and an initial bankroll
# Player can go to different games via menu
# Slots
# High / Low
# Player places bet and wins / loses (hint: rand)
# Player's bankroll goes up and down with wins and losses

require 'pry'
require_relative 'anscii_art'
require_relative 'gambler'
require_relative 'slots'
require_relative 'deck'
require_relative 'card'
require_relative 'instructions'

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
  puts "what would you like to do?"
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
    puts "Invalid selection!"
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
  puts "1) Slots\n2) High / Low"
end

def player_game_selection(choice)
  case choice
  when 1
    play_slots
  when 2
    play_high_low
  end
end

def play_slots
  AnsciiArt.slots_art
  puts 'Thanks for choosing the slots! Each spin is $1.'
  puts 'Get three matching values to win.'
  s = Slots.new('slot machine', 15)
  puts "You currently have: $#{@gambler.money -= 1}"
  s.spin
  if s.win
    @gambler.money += s.jackpot
    puts "You currently have: $#{@gambler.money}"
  end
  puts "\nSpin again?"
  print '> '
  input = gets.strip
  if input.downcase == 'y'
    play_slots
  else
    main_menu
  end
end

def play_high_low
  puts 'Thanks for choosing High / Low! Max bet: $1000. Min bet: $5'
  puts 'would you like to view the instructions?'
  input = gets.strip
  Instructions.high_low_instructions if input.downcase == 'y'
  deck = Deck.new
  print 'Play again?(y/n): '
  input == gets.strip
  play_high_low if input.downcase == 'y'
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

def goodbye
  puts "Goodbye!"
  exit
end

intro
loop do
  main_menu
end
