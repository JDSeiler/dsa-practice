# frozen_string_literal: true

require_relative './point_2d'

# Axis-Aligned Bounding Box
class AABB
  attr_accessor :center, :half_dim, :closed

  # - center (Point2D): The center point of the box
  # - half_dim (float): 1/2 the side-length of the box
  # - closed (boolean - optional): Defaults to `true` and controls whether
  #   points on the edge of the AABB are considered "inside". "Open" boxes
  #   include points on the edge, while "closed" boxes do not.
  def initialize(center, half_dim, closed = true)
    @center = center
    @half_dim = half_dim
    @closed = closed
  end

  def contains_point(p)
    diff_x = (center.x - p.x).abs
    diff_y = (center.y - p.y).abs

    return diff_x < @half_dim && diff_y < @half_dim if closed

    diff_x <= @half_dim && diff_y <= @half_dim
  end

  def intersects(other)
    other_inside = other.corners.any? do |other_corner|
      contains_point(other_corner)
    end

    self_inside = corners.any? do |own_corner|
      other.contains_point(own_corner)
    end

    other_inside || self_inside
  end

  def corners
    transforms = [
      [@half_dim, @half_dim],
      [@half_dim, -@half_dim],
      [-@half_dim, -@half_dim],
      [@half_dim, @half_dim]
    ]
    transforms.map do |t|
      tx = t[0]
      ty = t[1]
      Point2D.new(@center.x + tx, @center.y + ty)
    end
  end
end
