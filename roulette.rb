# frozen_string_literal: true

require 'colorize'
require_relative 'gambler'

class Roulette
  attr_accessor :winning_number,
                :bet,
                :numbers,
                :zone,
                :even_or_odd,
                :color_bet

  def initialize(bet,
                 numbers = nil,
                 zone = nil,
                 even_or_odd = nil,
                 color_bet = nil)

    @bet = bet
    @player_numbers = numbers
    @zone = zone
    @even_or_odd = even_or_odd
    @color_bet = color_bet
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
      print 'Green: ', number.to_s.colorize(:green)
      @color = 'green'
    elsif number.to_i.odd?
      print 'Red: ', number.to_s.colorize(:red)
      @color = 'red'
    elsif number.to_i.even?
      print 'Black: ', number.to_s.colorize(:white)
      @color = 'black'
    else
      raise 'Error: no result in spin_wheel'.colorize(:yellow)
    end
    evaluate_color(number)
  end

  def evaluate_color(_number)
    color_bet = @color_bet.downcase
    if @color.match?(color_bet)
      puts 'You guessed the right color!'
      true
    end
  end

  def evaluate_even_odd(_number)
    case @even_or_odd
    when 'even'
      true if number.even?
    when 'odd'
      true if number.odd?
    end
  end
end

r = Roulette.new(40)
r.spin_wheel
