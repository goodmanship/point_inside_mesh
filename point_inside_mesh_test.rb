require 'test/unit'
require './point_inside_mesh.rb'

class MyTest < Test::Unit::TestCase
  def setup
    @mesh = [
      [Vector[0.0, 0.0, 0.0], Vector[1.0, 0.0, 0.0], Vector[0.0, 1.0, 0.0]],
      [Vector[0.0, 0.0, 0.0], Vector[0.0, 1.0, 0.0], Vector[0.0, 0.0, 1.0]],
      [Vector[0.0, 0.0, 0.0], Vector[0.0, 0.0, 1.0], Vector[1.0, 0.0, 0.0]],
      [Vector[0.0, 0.0, 1.0], Vector[1.0, 0.0, 0.0], Vector[0.0, 1.0, 0.0]]
    ]
  end

  def test_outside
    point = Vector[1.2, 1.2, 1.2]
    assert(
      !point_inside_mesh(point, @mesh),
      'Point was supposed to be outside the mesh'
    )
  end

  def test_inside
    point = Vector[0.2, 0.2, 0.2]
    assert(
      point_inside_mesh(point, @mesh),
      'Point was supposed to be inside the mesh'
    )
  end
end
