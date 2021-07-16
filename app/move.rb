require_relative './game'

# This function is called on every turn of a game. It's how your Battlesnake decides where to move.
# Valid moves are "up", "down", "left", or "right".
# TODO: Use the information in board to decide your next move.
def move(board)
  puts board
  game = Game.new(board)
  move = game.determine_move
  puts "MOVE: " + move

  { "move": move }
end
