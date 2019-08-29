# frozen_string_literal: true

require_relative '../anscii_art'
require_relative 'gambler'

class Slots
  attr_accessor :machine_name, :jackpot, :win

  def initialize(name, jackpot)
    @machine_name = name
    @jackpot = jackpot
  end

  def spin_options
    @spin_options = %w[7 BAR CHERRIES]
  end

  def spin
    spin_options
    spin1 = rand(1..3)
    spin2 = rand(1..3)
    spin3 = rand(1..3)

    case spin1
    when 1
      spin1 = @spin_options[0]
      print "#{spin1} "
    when 2
      spin1 = @spin_options[1]
      print "#{spin1} "
    when 3
      spin1 = @spin_options[2]
      print "#{spin1} "
    end
    case spin2
    when 1
      spin2 = @spin_options[0]
      print "#{spin2} "
    when 2
      spin2 = @spin_options[1]
      print "#{spin2} "
    when 3
      spin2 = @spin_options[2]
      print "#{spin2} "
    end
    case spin3
    when 1
      spin3 = @spin_options[0]
      print "#{spin3} "
    when 2
      spin3 = @spin_options[1]
      print "#{spin3} "
    when 3
      spin3 = @spin_options[2]
      print "#{spin3} "
    end
    puts "\n"
    winning_numbers(spin1, spin2, spin3)
  end

  def winning_numbers(spin1, spin2, spin3)
    puts "You win!" if @win = spin1 == spin2 && spin2 == spin3 ? true : false
  end
end
