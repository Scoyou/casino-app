# frozen_string_literal: true

require 'colorize'
require_relative 'gambler'

class Roulette
  attr_accessor :winning_number,
                :bet,
                :numbers,
                :zone,
                :even_or_odd,
                :color_bet,
                :table_win,
                :even_odd_win,
                :color_win,
                :zone_win

  def initialize(bet, numbers, zone, even_or_odd, color_bet)
    @bet = bet
    @player_numbers = numbers
    @zone = zone
    @even_or_odd = even_or_odd
    @color_bet = color_bet
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

    evaluate_color(color, number) unless @color_bet.nil?
    evaluate_even_odd(number) unless @even_or_odd.nil?
    zone(number) unless @zone.nil?
    table_numbers(number) unless @player_numbers.nil?
  end

  def evaluate_color(color, _number)
    color_bet = @color_bet.downcase
    if color.match?(color_bet)
      puts 'You guessed the right color!'
      @color_win = true
    end
  end

  def evaluate_even_odd(number)
    case @even_or_odd
    when 'even'
      if number.to_i.even?
        puts 'Number was even!'
        @even_odd_win = true
      end
    when 'odd'
      if number.to_i.odd?
        puts 'Number was odd!'
        @even_odd_win = true
      end
    end
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

    if zone == @zone
      puts "You guessed zone #{@zone} correctly!"
      @zone_win = true
    end
  end

  def table_numbers(number)
    num = number.to_i
    if @player_numbers.include?(num)
      puts "You guessed #{num} as one of your table numbers!"
      @table_win = true
    end
  end
end
