class Bench < ActiveRecord::Base
  validates :description, :lat, :lon, presence: true

  def self.in_bounds(bounds)
    Bench.where([
        "(lat BETWEEN ? AND ?) AND (lon BETWEEN ? AND ?)",
        bounds['southWest']['lat'].to_f,
        bounds['northEast']['lat'].to_f,
        bounds['southWest']['lng'].to_f,
        bounds['northEast']['lng'].to_f
      ])
  end
end
