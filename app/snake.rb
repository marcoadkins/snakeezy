require_relative './location'

class Snake
  attr_accessor :id, :head, :body, :length

  def initialize(snake_data)
    @id = snake_data[:id]
    @head = Head.new(snake_data[:head])
    @body = snake_data[:body].map {|b| BodyPart.new(b) }
  end

  class Head < Location; end
  class BodyPart < Location; end
end