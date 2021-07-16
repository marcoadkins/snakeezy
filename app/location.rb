class Location
  attr_accessor :x, :y

  def initialize(location_data)
    @x = location_data[:x]
    @y = location_data[:y]
  end
end