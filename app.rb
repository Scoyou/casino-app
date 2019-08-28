
# puts "Hello! Welcome to the game 21! What's your name?"
# @user_name = gets.strip
# puts "Thank you for choosing Ruby Casino #{@user_name}! How much money would you like to play with today?"
# cash = gets.chomp.to_i
# loop do
#  puts "Total cash: $#{cash}"
#  puts "How much would you like to bet?"
#  bet = gets.chomp.to_i
#  cash -= bet
# end

# def menu
#   puts 'Would you like the play a game?'
#   puts 'Press Y for Yes'
#   puts 'Press N for No'
#   @menu_choice = gets.chomp.downcase
#   if menu_choice == "y"
#     continue_game
#   elsif menu_choice == "n"
#     back_to_menu
#   else
#     puts 'Invalid input, try again'
#   end
# end

# menu
# menu
# def menu_choice
#   puts 'Okay, lets begin!'

# end



# class Card
#   attr_accessor :num, :suit

#   def initialize(num, suit)
#     raise "Invalid card" unless (1..13).include? num
#     @num = num
#     raise "Invalid suit" unless ["spades", "hearts", "diamonds", "clubs"].include? suit
#     @suit = suit
#   end

#   def value
#     @num > 10 ? 10 : @num
#   end

#   def to_s
#     ["","A",2,3,4,5,6,7,8,9,10,"J","Q","K"][num].to_s + 
#     {spades: "♠", hearts: "♥", diamonds: "♦", clubs: "♣"}[suit.to_sym]
#   end
# end

# class Deck
#   attr_accessor :cards, :cards_played

#   def initialize
#     @cards = (1..13).to_a.product(["spades", "hearts", "diamonds", "clubs"]).collect{|n,s| Card.new(n,s)}
#     @cards_played = []
#   end

#   def draw(n=1)
#     draw = @cards.sample(n).each do |card|
#       @cards_played.push @cards.delete(card)
#     end
#   end

#   def cards_left
#     @cards - @cards_played
#   end
# end

# deck = Deck.new
# hand = deck.draw(2)
# loop do
#   puts "Your cards are: "
#   puts hand
#   value = hand.map(&:value).sum
#   puts "Your hand's value is #{value}"
#   if value > 21
#     puts "Bust!"
#     break
#   end
#   puts "Hit (H) or Stay (S)?"
#   action = gets.chomp.downcase
#   if action == "s"
#     break
#   elsif action == "h"
#     hand += deck.draw
#   end
# end


# -------------- NEW CODE BELOW ----------------


# puts "How much money would you like to play with today?"
# cash = gets.chomp.to_i
# loop do
#     puts "Total cash: $#{cash}"
#     puts "How much would you like to bet?"
#     bet = gets.chomp.to_i
#     cash -= bet
# end

# ---- Works below


def menu
  puts 'Welcome to the Game of 21 Table!'
  sleep(1)
  puts 'Please choose an option:'
  sleep(1)
  puts '1) Play Game'
  puts '2) Bet some monies!'
  puts '3) Back to Menu'
end
menu

def options
  options = gets.to_i
  if options == "1"
    play_game
  elsif options == "2"
    bet_money
  elsif options == "3"
    back_to_menu
  else
    puts 'Invalid input, try again'
  end
end
options
menu

def bet_money
  puts "How much total money would you like to play with today? "
 cash = gets.chomp.to_i
  puts "Total cash:  $#{cash}"
  puts "How much would you like to bet? "
  bet = gets.chomp.to_i
  cash -= bet
end

  menu
  def deal_card
    rand(11)+1
  end
  
  def display_card_total(card_total)
    puts "Your cards add up to #{card_total}"
  end
  
  def display_oppontents_card_total(opp_card_total)
    puts "Your opponents cards equal #{opp_card_total}"
  end 
  
  def prompt_user
    puts "Type 'h' to hit or 's' to stay"
  end
  
  def get_user_input
    answer = gets.chomp
  end
  
  def end_game(card_total,opp_card_total)
    puts "Your opponents card total is #{opp_card_total}"
    puts "Sorry, you hit #{card_total}. Thanks for playing!"
  end
  
  def initial_round
  
    first_card = deal_card
  
    second_card = deal_card
  
    card_total = first_card+second_card
    
    return card_total
  end
  
  def dealer_initial_round
    dealer_hand=[]
    dealer_first_card = deal_card
    dealer_second_card = deal_card
    
    dealer_initial_round_total = dealer_first_card+dealer_second_card
    dealer_hand.push(dealer_initial_round_total)
    dealer_hand.push(dealer_first_card)
    dealer_hand.push(dealer_second_card)
    puts "Dealer is showing #{dealer_hand[1]}"
    return dealer_hand
  end 
  
  def stay_or_hit
    prompt_user
    answer = get_user_input
    answer
  end 
  
  
  def new_hit(card_total)
  card_total+=deal_card
  end 
  
  # begin
  def hit?(current_card_total)
    prompt_user
    answer = get_user_input
    if answer == 's'
      return current_card_total
    elsif answer == 'h'
      current_card_total+=deal_card
      display_card_total(current_card_total)
      return current_card_total
    else
      invalid_command
      hit?(current_card_total)
    end
  end
  # end

  def dealer_flip(dealer_hand)
    puts "Dealer Flips his second card."
    puts""
    sleep(2)
    puts "The dealer is showing #{dealer_hand[1]} and #{dealer_hand[2]}"
    puts ""
    sleep(2)
    puts "The dealer's total is #{dealer_hand[0]}"
    puts ""
    sleep(2)
  end
  
    def dealer_hits?(dealer_hand)
    while dealer_hand[0]<=16
    new_card= deal_card
    sleep(2)
    puts "The dealer draws a #{new_card}"
    puts ""
      dealer_hand[0] += new_card
      sleep(2)
      puts "The dealer's total is now #{dealer_hand[0]}"
      puts ""
    end
    if dealer_hand[0]<21
      puts"The dealer stands with #{dealer_hand[0]}"
      puts""
      dealer_total = dealer_hand[0]
      return dealer_total
    elsif dealer_hand[0]==21
      dealer_total = dealer_hand[0]
      return dealer_total
    else 
      puts "Dealer Busts!"
      return dealer_hand[0]
    end
  end 
  
  def winner?(dealer_total,card_total)
    if dealer_total==card_total
      puts "The Game is a Draw"
      return "House Wins"
    elsif dealer_total>card_total
      return "Dealer Wins with #{dealer_total}"
      elsif card_total>dealer_total
      return "You Win with #{card_total}"
    end
  end
  def invalid_command
    puts "Please enter a valid command"
  end

  def new_runner
   
  welcome
  card_total = initial_round
  display_card_total(card_total)
  dealer_hand=dealer_initial_round
  
  stay=false
  until (card_total>21 || stay)
    answer=stay_or_hit
    if answer =='h'
    card_total=new_hit(card_total)
    display_card_total(card_total)
    elsif answer =='s'
    stay=true
    else
      invalid_command
    end 
    end
    if card_total==21
      puts "You win!!"
      return "You Win!!"
    end 
    if card_total>21
      puts "You Bust!"
      return "Dealer wins!"
    end 
    dealer_flip(dealer_hand)
    dealer_total=dealer_hits?(dealer_hand)
    if dealer_total>21
      return "You Win!"
    end
    winner?(dealer_total,card_total)
  end 
  menu
  new_runner
  
#  begin
#  def runner
#  welcome
#  card_total = initial_round
#  opp_card_total = opp_initial_round

#  while card_total<21
#  opp_card_total=opp_hit?(opp_card_total)
#  card_total= hit?(card_total)
#  display_card_total(card_total)
#  end
#  end_game(card_total,opp_card_total)
#  begin puts""
#  puts"--------------NEW GAME----------"
#  end runner
