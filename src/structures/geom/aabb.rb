# frozen_string_literal: true

require_relative './point_2d'

# Axis-Aligned Bounding Box
class AABB
  attr_accessor :center, :half_dim

  # - center (Point2D): The center point of the box
  # - half_dim (float): 1/2 the side-length of the box
  def initialize(center, half_dim)
    @center = center
    @half_dim = half_dim
  end

  def contains_point(p)
    diff_x = (center.x - p.x).abs
    diff_y = (center.y - p.y).abs

    # Points on the line are a literal edge case I need to consider.
    diff_x < @half_dim && diff_y < @half_dim
  end

  def intersects(other)
    manhattan_distance(@center, other.center) < (2 * @half_dim + 2 * other.half_dim)
  end

  private

  def manhattan_distance(point_a, point_b)
    (point_a.x - point_b.x).abs + (point_a.y - point_b.y).abs
  end
end
