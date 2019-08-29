

require_relative 'ruby_casino'

game = RubyCasino.new
game.intro
loop do
  game.main_menu
end
