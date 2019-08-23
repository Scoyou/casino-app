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


def intro
  puts "As you enter the casino you are greeted by the doorsman."
  puts '"May I see some Identification please?"'
  print "Enter your name: "
  name = gets.strip.capitalize
  print "Enter your age: "
  age = gets.to_i
  if age < 21
    puts "Sorry, but you must be 21 or older to enter."
    exit
  else
    AnsciiArt.intro_art
    puts "Welcome to the ruby casino, #{name}!"
    @gambler = Gambler.new(name, age)
    menu
  end
end


def menu
  puts "Which game would you like to play?"
  list_games
  print '> '
  choice = gets.to_i
  player_selection(choice)
end

def list_games
  puts "1) Slots\n2) High / Low"
end

def player_selection(choice)
  case choice
  when 1
    play_slots
  when 2
    # TODO high_low
  end
end

def play_slots
  AnsciiArt.slots_art
  puts "Thanks for choosing the slots! Each spin is $1."
  puts "Get three matching values to win."
  s = Slots.new('slot machine', 15)
  s.spin
  @gambler.money -= 1
  puts "\n", @gambler.money
  if s.win
    @gambler.money += s.jackpot
    puts @gambler.money
  end
  puts "\nSpin again?"
  print '> '
  input = gets.strip
  if input.downcase == 'y'
    play_slots
  else
    menu
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
intro
