# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  COLORS = ["red", "blue", "yellow", "purple"]

  validates :color, inclusion: COLORS, presence: true
  validates :name, :birth_date, presence: true
  validates :sex, inclusion: ["M","F"], presence: true


  has_many :rentals,
    class_name: 'CatRentalRequest',
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy

  #Using birth_date
  def age
    ((Date.today - birth_date) / 365.25).to_i
  end

end
