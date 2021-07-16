class Grid
  attr_accessor :grid

  def initialize(height, width)
    @grid = Array.new(width) { Array.new(height, 0) }
  end

  def draw_snake(s)
    grid[s.head.x][s.head.y] = 1
    s.body.each do |b|
      grid[b.x][b.y] = 's'
    end
  end

  def draw_food(f)
    grid[f.x][f.y] = 'f'
  end
end