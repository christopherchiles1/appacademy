# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           not null
#

class CatRentalRequest < ActiveRecord::Base
  STATUS = ["PENDING", "APPROVED", "DENIED"]
  before_validation :ensure_status

  validates :start_date, :end_date, :cat_id, presence: true
  validates :status, inclusion: { in: STATUS }
  validate :no_two_overlapping_approved_requests

  belongs_to :cat,
    class_name: 'Cat',
    foreign_key: :cat_id,
    primary_key: :id

  def approve!
    transaction do
      overlapping_pending_requests.each(&:deny!)
      self.status = "APPROVED"
      self.save!
    end
  end

  def deny!
    # transaction do
    self.update!(status: "DENIED")
    # self.status = "DENIED"
    # self.save!
    # end
  end

  def pending?
    self.status == "PENDING"
  end

  private
  def ensure_status
    self.status ||= "PENDING"
  end

  def overlapping_requests
     overlaps = CatRentalRequest
                  .where("? IS NOT NULL AND id != ? AND cat_id = ? AND
                  (? BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date
                  OR ? BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date)",
                  id, id, cat_id, start_date, end_date)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def no_two_overlapping_approved_requests
    overlaps = overlapping_approved_requests
    unless overlaps.empty?
      errors[:base] << "No two approved overlapping requests!"
    end
  end
end
