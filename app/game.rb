require_relative './snake'
require_relative './food'
require_relative './grid'

class Game
  attr_accessor :height, :width, :me, :snakes, :food, :grid

  DIRECTIONS = ["up", "down", "left", "right"]

  def initialize(game_data)
    @height = game_data[:board][:height]
    @width = game_data[:board][:width]
    @me = Snake.new(game_data[:you])
    @snakes = enemy_snake_data(game_data).map { |snake_data| Snake.new(snake_data) }
    @food = game_data[:board][:food].map { |food_data| Food.new(food_data) }
    @grid = Grid.new(height, width)

    setup_grid

    puts "Game: #{self.inspect}"
    puts "Grid: #{grid.grid.inspect}"
  end

  def determine_move
    scores = {'up' => 0, 'down' => 0, 'left' => 0, 'right' => 0}
    x = me.head.x
    y = me.head.y
    3.times do
      DIRECTIONS.shuffle.each do |direction|
        x,y = move_cords(x, y, direction)
        scores[direction] += 1 if traversable?(x,y)
      end
    end

    scores.max_by{ |_k,v| v }[0]
  end

  def move_cords(x,y, direction)
    case direction
    when 'up'
      [x, y + 1]
    when 'down'
      [x, y - 1]
    when 'left'
      [x - 1, y]
    when 'right'
      [x + 1, y]
    end
  end

  private

  def setup_grid
    food.each do |f|
      grid.draw_food(f)
    end

    snakes.each do |s|
      grid.draw_snake(s)
    end

    grid.draw_snake(me)
  end

  def enemy_snake_data(game_data)
    game_data[:board][:snakes].filter do |snake_data|
      snake_data[:id] == game_data[:you][:id]
    end
  end

  def in_bounds?(x, y)
    return false if x < 0 || x >= width
    return false if y < 0 || y >= height
    true
  end

  def traversable?(x, y)
    puts "CORDS: #{[x,y]}"
    puts "IN BOUNDS: #{in_bounds?(x,y)}"
    puts "EMPTY?: #{grid.empty?(x,y)}"
    in_bounds?(x,y) && grid.empty?(x,y)
  end
end