# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true

  def self.random_code
    code = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom.urlsafe_base64
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(
      long_url: long_url,
      submitter_id: user.id,
      short_url: ShortenedUrl.random_code
    )
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    #visits.select(:visitor_id).distinct.count
    unique_visitors.count
  end

  def num_recent_uniques
    visits.select(:visitor_id).where("updated_at >= ?", 10.minutes.ago)
      .distinct
      .count
  end

  belongs_to :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits,
    class_name: 'Visit',
    foreign_key: :shortened_url_id,
    primary_key: :id

  has_many :visitors,
    :through => :visits,
    :source => :user

  has_many :unique_visitors, -> { distinct },
    :through => :visits,
    :source => :user

end
