class Point < ApplicationRecord
  def self.within_radius(radius, longitude, latitude)
    radius = radius.to_i
    longitude = longitude.to_f
    latitude = latitude.to_f

    sql = <<-SQL
      SELECT *, ROUND(earth_distance(ll_to_earth(?, ?), ll_to_earth(latitude, longitude))::NUMERIC, 2) AS distance
      FROM points
      WHERE earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(latitude, longitude)
      AND earth_distance(ll_to_earth(?, ?), ll_to_earth(latitude, longitude)) < ?
      ORDER BY distance
    SQL

    Point.find_by_sql([sql, latitude, longitude, latitude, longitude, radius, latitude, longitude, radius])
  end
end
