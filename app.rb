

require_relative './classes/ruby_casino'

game = RubyCasino.new
game.intro
loop do
  game.main_menu
end
