# frozen_string_literal: true

class Craps

  def initialize
    puts 'Welcome to Craps'
    srand Time.now.tv_sec
  end

  def getroll
    rand(2..7) + rand(6)
  end

  def game
    roll1 = getroll
    puts 'You rolled ' + roll1.to_s
    case roll1
    when 7, 11, 12
      puts 'You win!'
    when 2, 3
      puts 'You lose!'
    else
      puts 'Roll again!'
    end
    point = getroll
    puts 'Point is ' + point.to_s
    case point
    when 7
      puts 'You lose!'
    when roll1
      puts 'You win!'
    end
    roll2 = 0
    while point != roll2
      roll2 = getroll
      puts 'You rolled ' + roll2.to_s
      case roll2
      when 7
        puts 'You lose!'
      when point
        puts 'You win!'
      else
        puts 'Roll again'
      end
    end
  end
end
