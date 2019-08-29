# frozen_string_literal: true

require 'pry'
require 'colorize'
require_relative 'gambler'
require_relative 'string'

class Roulette
  attr_accessor :player_numbers,
                :player_zone,
                :even_or_odd,
                :player_color,
                :table_win,
                :zone_win,
                :color_win,
                :even_odd_win,
                :bet

  def initialize
    get_bets
    @table_win = false
    @zone_win = false
    @color_win = false
    @even_odd_win = false
  end

  def wheel
    @wheel = %w[
      0 2 14 35 23 4
      16 33 21 6 18 31
      19 8 12 29 25 10
      27 00 1 13 36 24
      3 15 34 22 5 17
      32 20 7 11 30 26
      9 28
    ]
  end

  def spin_wheel
    wheel
    number = @wheel.sample
    if number == '0' || number == '00'
      print 'Green: '.colorize(:green), "#{number}\n"
      color = 'green'
    elsif number.to_i.odd?
      print 'Red: '.colorize(:red), "#{number}\n"
      color = 'red'
    elsif number.to_i.even?
      print 'Black: '.colorize(:white), "#{number}\n"
      color = 'black'
    else
      raise 'Error: no result in spin_wheel'.colorize(:yellow)
    end
    evaluate_color(color, number) unless @player_color.nil?
    evaluate_even_odd(number) unless @even_or_odd.nil?
    zone(number) unless @player_zone.nil?
    table_numbers(number) unless @player_numbers.nil?
  end

  def evaluate_color(color, _number)
    color_bet = @player_color.downcase
    @color_win = color.match?(color_bet) ? true : false
    puts 'You guessed the right color!' if @color_win
  end

  def evaluate_even_odd(number)
    case @even_or_odd
    when 'even'
      @even_odd_win = number.to_i.even? ? true : false
    when 'odd'
      @even_odd_win = number.to_i.odd? ? true : false
    end
    puts "Number was #{@even_or_odd}!" if @even_odd_win
  end

  def zone(number)
    num = number.to_i
    case num
    when 1..12
      zone = 1
    when 13..22
      zone = 2
    when 23..34
      zone = 3
    end
    puts "You guessed zone #{@zone} correctly!" if @zone_win = zone == @zone
  end

  def table_numbers(number)
    @table_win = @player_numbers.include?(number) ? true : false
    puts "You guessed #{number} as one of your table numbers!" if @table_win
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
    input.is_valid_number? ? (@bet = input.to_i) : set_bet_amount
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
    input.is_y_or_n? ? (input.downcase == 'y' ? even_or_odd_setter :
                              @even_or_odd = nil) :
                              place_even_odd_bet
  end

  def place_zone_bet
    print 'Would you like to place a number bet for a certain zone(Y/N)? '
    input = gets.chomp
    input.is_y_or_n? ? (input.downcase == 'y' ? zone_bet :
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
    valid = pattern.match?(input) ? (@player_color = input) : false
    bet_on_colors unless valid
  end

  def even_or_odd_setter
    print 'Even or odd? '
    input = gets.chomp.downcase
    pattern = /even|odd/
    valid = pattern.match?(input) ? (@even_or_odd = input) : false
    even_or_odd_setter unless valid
  end

  def zone_bet
    puts "Zones are: \n1) 1-12\n2) 13-22\n3) 23-34"
    print 'Which zone would you like to bet on?(1, 2, or 3): '
    input = gets.chomp
    pattern = /[1-3]/
    valid = pattern.match?(input) ? (@player_zone = input) : false
    zone_bet unless valid
  end
end
