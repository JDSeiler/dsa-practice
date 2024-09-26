# frozen_string_literal: true

require 'rspec'
require_relative '../../../src/structures/geom/aabb'

describe AABB do
  describe '::new' do
    it 'returns a new instance of AABB' do
      expect(AABB.new(Point2D.new(1, 2), 3)).to be_an_instance_of(AABB)
    end
  end

  describe '#contains_point' do
    let(:aabb) { AABB.new(Point2D.new(5, 5), 5) }

    it 'returns true if the point is inside the box' do
      point = Point2D.new(4, 6)
      expect(aabb.contains_point(point)).to be(true)
    end

    it 'returns false if the point is outside the box' do
      point = Point2D.new(-1, -1)
      expect(aabb.contains_point(point)).to be(false)
    end

    it 'returns true for points on the edge when closed=false' do
      aabb = AABB.new(Point2D.new(5, 5), 10, false)
      point = Point2D.new(15, 15)
      expect(aabb.contains_point(point)).to be(true)
    end

    it 'returns false for points on the edge when closed=true' do
      # closed=true is the default value
      aabb = AABB.new(Point2D.new(5, 5), 10)
      point = Point2D.new(15, 15)
      expect(aabb.contains_point(point)).to be(false)
    end
  end

  describe '#intersects' do
    let(:aabb1) { AABB.new(Point2D.new(0, 0), 10) }
    let(:aabb2) { AABB.new(Point2D.new(-5, -5), 20) }

    it 'returns true if the boxes intersect' do
      expect(aabb1.intersects(aabb2)).to be(true)
    end

    it 'returns false if the boxes do not intersect' do
      # Corner is touching, but that's all
      aabb2 = AABB.new(Point2D.new(15, 15), 5)
      expect(aabb1.intersects(aabb2)).to be(false)
    end

    it 'returns false if the boxes touch only along an edge' do
      # 15 < 20 + 10
      aabb2 = AABB.new(Point2D.new(15, 0), 5)
      expect(aabb1.intersects(aabb2)).to be(false)
    end

    # Tons of edge cases left to test but I can't be bothered right now
  end
end
