require_relative './snake'
require_relative './food'
require_relative './grid'

class Game
  attr_accessor :height, :width, :me, :snakes, :food, :grid

  DIRECTIONS = %w[up down left right]

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

  def determine_best_move
    DIRECTIONS.shuffle.each do |direction|
      puts "DIRECTION: #{direction}"
      return direction if traversable?(*me.head.send(direction))
    end

    'up'
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
    puts "EMPTY?: #{grid.empty?(x,y)}"
    in_bounds?(x,y) && grid.empty?(x,y)
  end
end