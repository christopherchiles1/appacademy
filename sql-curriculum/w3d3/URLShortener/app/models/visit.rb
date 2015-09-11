# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  visitor_id       :integer
#  shortened_url_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Visit < ActiveRecord::Base
  validates :visitor_id, presence: true
  validates :shortened_url_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(visitor_id: user.id, shortened_url_id: shortened_url.id)
  end

  belongs_to :user,
    class_name: 'User',
    foreign_key: :visitor_id,
    primary_key: :id

  belongs_to :shortened_url,
    class_name: 'ShortenedUrl',
    foreign_key: :shortened_url_id,
    primary_key: :id
end
