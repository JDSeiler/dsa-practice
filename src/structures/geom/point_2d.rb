# frozen_string_literal: true

# 2-dimensional point
class Point2D
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  # Component-wise equality
  def ==(other)
    @x == other.x && @y == other.y
  end

  def manhattan_distance(p)
    (@x - p.x).abs + (@y - p.y).abs
  end
end
