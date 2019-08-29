# frozen_string_literal: true

# Start game player has a name and an initial bankroll
# Player can go to different games via menu
# Slots
# High / Low
# Player places bet and wins / loses (hint: rand)
# Player's bankroll goes up and down with wins and losses


require 'pry'
require_relative '../anscii_art'
require_relative '../instructions'
require_relative 'gambler'
require_relative 'slots'
require_relative 'roulette'
require_relative 'string'
require_relative 'blackjack'
require_relative 'craps'

class RubyCasino
  attr_accessor :gambler

  def initialize
    @gambler = intro
  end

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
      return Gambler.new(name, @age)
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
    puts "1) Slots\n2) Roulette\n3) Blackjack\n4) Craps"
  end

  def player_game_selection(choice)
    case choice
    when 1
      @gambler.out_of_money? ? (puts 'You dont have any money left!') : play_slots
    when 2
      @gambler.out_of_money? ? (puts 'You dont have any money left!') : play_roulette
    when 3
      @gambler.out_of_money? ? (puts 'You dont have any money left!') : play_blackjack
    when 4
      @gambler.out_of_money? ? (puts 'You dont have any money left!') : play_craps
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

  def play_roulette
    puts 'Thanks for choosing Roulette!'
    print 'Would you like to view the instructions(Y/N)? '
    input = gets.chomp
    puts "\n"
    Instructions.roulette if input.downcase == 'y'

    game = Roulette.new
    game.spin_wheel
    evaluate_roulette_winnings(game)
    puts "money after winnings is #{@gambler.money}"
    @gambler.out_of_money? ? (puts 'You dont have any money left!') :
                              ask_to_play_again('roulette')
  end

  def play_blackjack
    blackjack = Blackjack.new
    blackjack.menu
    ask_to_play_again('blackjack')
  end

  def play_craps
    craps = Craps.new
    craps.game
    ask_to_play_again('craps')
  end

  def evaluate_roulette_winnings(game)
    unless game.player_numbers.nil?
           game.table_win ? (@gambler.money += (game.bet * 35)) :
                       (@gambler.money -= game.bet)
    end
    unless game.player_zone.nil?
           game.zone_win ? (@gambler.money += game.bet) :
                      (@gambler.money -= game.bet)
    end
    unless game.even_or_odd.nil?
           game.even_odd_win ? (@gambler.money += game.bet) :
                          (@gambler.money -= game.bet)
    end
    unless game.player_color.nil?
           game.color_win ? (@gambler.money += game.bet) :
                       (@gambler.money -= game.bet)
    end
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
      when 'blackjack'
        input.downcase == 'y' ? play_blackjack : main_menu
      when 'craps'
        input.downcase == 'y' ? play_craps : main_menu
      end
    else
      ask_to_play_again(game)
    end
  end

  def goodbye
    puts 'Goodbye!'
    exit
  end
end
