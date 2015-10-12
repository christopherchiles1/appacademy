class Bench < ActiveRecord::Base
  validates :description, :lat, :lon, :seating, presence: true

  def self.in_bounds(bounds)
    lat1 = bounds['southWest']['lat'].to_f
    lat2 = bounds['northEast']['lat'].to_f
    lng1 = bounds['southWest']['lng'].to_f
    lng2 = bounds['northEast']['lng'].to_f
    if (lng1 > lng2)
      Bench.where([
          "(lat BETWEEN ? AND ?) AND ((lon BETWEEN ? AND ?) OR (lon BETWEEN ? AND ?))",
          lat1, lat2, lng1, 180, -180, lng2
        ])
    else
      Bench.where([
          "(lat BETWEEN ? AND ?) AND (lon BETWEEN ? AND ?)",
          lat1, lat2, lng1, lng2
        ])
    end
  end
end
