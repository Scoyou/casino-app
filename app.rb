puts "Welcome to Ruby Casino! What's your name?"
@user_name = gets.strip
puts "Thank you for choosing Ruby Casino #{@user_name}! How much money would you like to play with today?"
cash = gets.chomp.to_i
loop do
 puts "Total cash: $#{cash}"
 puts "How much would you like to bet?"
 bet = gets.chomp.to_i
 cash -= bet
 def init
  puts "Welcome to Craps"
   srand Time.now.tv_sec
 end
 def getroll
   2 + rand(6) + rand(6)
 end
 init
 roll1 = getroll
 puts "You rolled " + roll1.to_s
   case roll1
   when 7, 11, 12
     puts "You win!"
       exit
   when 2, 3
     puts "You lose!"
       exit
   else
     puts "Roll again!".
   end
 end
   point = getroll
   puts "Point is " + point.to_s
   case point
     when 7
       puts "You lose!"
     exit
     when roll1
       puts "You win!"
     exit
   end
    roll2 = 0
     while point != roll2
     roll2 = getroll
     puts "You rolled " + roll2.to_s
     case roll2
       when 7
       puts "You lose!"
     exit
       when point
       puts "You win!"
     exit
     else
       puts "Roll again"
   end
 end
end

