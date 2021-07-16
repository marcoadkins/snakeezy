require_relative './snake'
require_relative './food'
require_relative './grid'

class Game
  attr_accessor :height, :width, :me, :snakes, :food, :grid

  def initialize(game_data)
    @height = game_data[:board][:height]
    @width = game_data[:board][:width]
    @me = Snake.new(game_data[:you])
    @snakes = enemy_snake_data(game_data).map { |snake_data| Snake.new(snake_data) }
    @food = game_data[:board][:food].map { |food_data| Food.new(food_data) }
    @grid = Grid.new(height, width)

    setup_grid
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
end