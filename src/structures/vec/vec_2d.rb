# frozen_string_literal: true

require_relative '../geom/point_2d'

# 2-dimensional vector class
class Vec2D < Point2D
  # Component-wise addition of `self` and `other`.
  def +(other)
    Vec2D.new(@x + other.x, @y + other.y)
  end

  # Component-wise subtraction of `self` and `other`.
  def -(other)
    Vec2D.new(@x - other.x, @y - other.y)
  end

  # Returns the dot product between `self` and `other`.
  def dot(other)
    @x * other.x + @y * other.y
  end

  # Returns the length of `self`.
  def magnitude
    Math.sqrt(@x**2 + @y**2)
  end

  # Returns a normalized version of `self`, that is, a vector pointing
  # the same direction but with magnitude 1.
  def normalized
    m = magnitude # don't compute magnitude twice
    raise ArgumentError.new, 'The norm is not defined for vectors with a magnitude of 0' if m.zero?

    Vec2D.new(@x / m, @y / m)
  end

  # Returns the angle between `self` and `other` in radians.
  # If the vectors point in opposite directions, this value will be PI.
  # If the vectors point in the same direction, this value will be 0.
  # Thus, the domain of this function is [0, PI].
  def angle_with(other)
    # a.dot(b) = a.magnitude * b.magnitude * cos(theta)
    # a.dot(b) / (a.magnitude * b.magnitude) = cos(theta)
    # arccos(...) = theta

    # What is the angle between a vector and the origin?
    # It's a nonsense question and the algebra shows it
    # because it involves division by zero.
    magnitude_divisor = magnitude * other.magnitude
    if magnitude_divisor.zero?
      raise ArgumentError.new, 'Cannot take angle between vectors when either vector has a magnitude of 0'
    end

    cos_theta = dot(other) / magnitude_divisor
    Math.acos(cos_theta)
  end
end
