require 'matrix'

# Implementation of Möller-Trumbore intersection algorithm
# https://en.wikipedia.org/wiki/M%C3%B6ller%E2%80%93Trumbore_intersection_algorithm
def ray_triangle_intersection(ray_origin, ray_direction, v0, v1, v2)
  epsilon = 1e-6

  edge1 = v1 - v0
  edge2 = v2 - v0

  h = ray_direction.cross(edge2)
  a = edge1.dot(h)

  return false if a.abs < epsilon # Ray is parallel to triangle

  f = 1.0 / a
  s = ray_origin - v0
  u = f * s.dot(h)

  # Check if the ray-plane intersection point is outside the triangle
  return false if u < 0.0 || u > 1.0

  q = s.cross(edge1)
  v = f * ray_direction.dot(q)

  return false if v < 0.0 || u + v > 1.0

  # Compute t to find out where the intersection point is on the line
  t = f * edge2.dot(q)

  t > epsilon
end

# Extend a ray from the point in any direction. Count the number of triangles
# that are intersected by the ray. If the number is odd, the point is inside the mesh.
# If it's even (including 0), the point is outside the mesh.
def point_inside_mesh(point, mesh)
  ray_origin = point
  ray_direction = Vector[1.0, 0.0, 0.0] # Cast ray along the positive x-axis
  intersection_count = 0

  mesh.each do |triangle|
    v0, v1, v2 = triangle
    if ray_triangle_intersection(ray_origin, ray_direction, v0, v1, v2)
      intersection_count += 1
    end
  end

  intersection_count.odd?
end