# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  body       :text             not null
#  done       :boolean          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Todo < ActiveRecord::Base
  after_initialize :ensure_done

  validates :title, :body, presence: true
  validates :done, inclusion: [true, false]

  def ensure_done
    self.done ||= false
  end
end
