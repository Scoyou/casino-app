# frozen_string_literal: true

class Gambler
  attr_accessor :name, :age, :money

  def initialize(name, age)
    @name = name
    @age = age
    @money = get_starting_funds
  end

  def get_starting_funds
    print 'How much money do you have?: '
    input = gets.chomp
    until is_valid_number?(input)
      print 'How much money do you have?: '
      input = gets.chomp
    end
    money = input.to_f
    return money
    check_wallet
  end

  def check_wallet
    puts "you have $#{@money} in your wallet."
    print 'Would you like to add more funds? (Enter Y for Yes): '
    input = gets.chomp
    add_funds if input.downcase == 'y'
  end

  def add_funds
    print 'How much money would you like to add?: '
    input = gets.chomp
    until is_valid_number?(input)
      print 'How much money would you like to add?: '
      input = gets.chomp
    end
    @money += input.to_f
    puts "New wallet total is: $#{@money}"
  end

  def out_of_money?
    true if @money <= 0
  end
end
