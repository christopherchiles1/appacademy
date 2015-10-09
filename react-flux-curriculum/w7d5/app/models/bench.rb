class Bench < ActiveRecord::Base
  validates :description, :lat, :lon, presence: true
end
