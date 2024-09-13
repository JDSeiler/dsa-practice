require 'rspec'
require_relative '../../../src/structures/vec/vec_2d'

# epsilon / floating point comparison tolerance
EPS = 0.000001

describe Vec2D do
  describe '::new' do
    it 'returns a new instance of Vec2D' do
      expect(Vec2D.new(1, 2)).to be_an_instance_of(Vec2D)
    end
  end

  describe '#x' do
    it 'returns the x component of a vector' do
      v = Vec2D.new(1, 2)
      expect(v.x).to eq(1)
    end

    it 'sets the x component of a vector' do
      v = Vec2D.new(0, 0)
      expect(v.x).to eq(0)
      v.x = 1
      expect(v.x).to eq(1)
    end
  end

  describe '#y' do
    it 'returns the y component of a vector' do
      v = Vec2D.new(1, 2)
      expect(v.y).to eq(2)
    end

    it 'sets the y component of a vector' do
      v = Vec2D.new(0, 0)
      expect(v.y).to eq(0)
      v.y = 1
      expect(v.y).to eq(1)
    end
  end

  describe '#+' do
    it 'adds two vectors component-wise' do
      v1 = Vec2D.new(1, 2)
      v2 = Vec2D.new(3, 4)
      expect(v1 + v2).to eq(Vec2D.new(4, 6))
    end

    it 'works with zero vector' do
      v = Vec2D.new(0, 0)
      expect(v + Vec2D.new(1, 2)).to eq(Vec2D.new(1, 2))
    end
  end

  describe '#-' do
    it 'subtracts two vectors component-wise' do
      v1 = Vec2D.new(3, 4)
      v2 = Vec2D.new(1, 2)
      expect(v1 - v2).to eq(Vec2D.new(2, 2))
    end

    it 'works with zero vector' do
      v = Vec2D.new(0, 0)
      expect(v - Vec2D.new(1, 2)).to eq(Vec2D.new(-1, -2))
    end
  end

  describe '#dot' do
    it 'returns the dot product of two vectors' do
      v1 = Vec2D.new(1, 2)
      v2 = Vec2D.new(3, 4)
      expect(v1.dot(v2)).to eq(11)
    end

    it 'works with the zero vector' do
      v = Vec2D.new(1, 3)
      origin = Vec2D.new(0, 0)
      expect(v.dot(origin)).to eq(0)
    end
  end

  describe '#magnitude' do
    it 'returns the magnitude of a vector' do
      v = Vec2D.new(3, 4)
      expect(v.magnitude).to be_within(EPS).of(Math.sqrt(25))
    end

    it 'works with the zero vector' do
      v = Vec2D.new(0, 0)
      expect(v.magnitude).to be_within(EPS).of(0)
    end

    it 'works with axis-aligned vectors' do
      v = Vec2D.new(0, 10)
      expect(v.magnitude).to be_within(EPS).of(10)
    end
  end

  describe '#normalized' do
    it 'returns a normalized version of a vector' do
      v = Vec2D.new(3, 4)
      expect(v.normalized.magnitude).to be_within(EPS).of(1.0)
    end

    it 'does not affect the angle of the vector' do
      v = Vec2D.new(20, 20)
      x_axis = Vec2D.new(1, 0)
      expect(v.angle_with(x_axis)).to be_within(EPS).of(Math::PI / 4)

      v_norm = v.normalized
      expect(v_norm.angle_with(x_axis)).to be_within(EPS).of(Math::PI / 4)
    end

    it 'raises ArgumentError when trying to normalize the zero vector' do
      v = Vec2D.new(0, 0)
      expect { v.normalized }.to raise_error(ArgumentError)
    end
  end

  describe '#angle_with' do
    it 'returns the angle between two vectors in radians' do
      v1 = Vec2D.new(1, 0)
      v2 = Vec2D.new(0, 1)
      expect(v1.angle_with(v2)).to be_within(EPS).of(Math::PI / 2)
    end

    it 'returns PI if the vectors point in opposite directions' do
      v1 = Vec2D.new(1, 0)
      v2 = Vec2D.new(-1, 0)
      expect(v1.angle_with(v2)).to be_within(EPS).of(Math::PI)
    end

    it 'returns 0 if the vectors point in the same direction' do
      v1 = Vec2D.new(1, 0)
      v2 = Vec2D.new(1, 0)
      expect(v1.angle_with(v2)).to be_within(EPS).of(0)
    end

    it 'raises an ArgumentError when one vector has a magnitude of 0' do
      v1 = Vec2D.new(1, 0)
      origin = Vec2D.new(0, 0)
      expect { v1.angle_with(origin) }.to raise_error(ArgumentError)
      expect { origin.angle_with(v1) }.to raise_error(ArgumentError)
    end

    it 'raises an ArgumentError when both vectors have a magnitude of 0' do
      v1 = Vec2D.new(0, 0)
      origin = Vec2D.new(0, 0)
      expect { v1.angle_with(origin) }.to raise_error(ArgumentError)
    end
  end
end
