class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, inclusion: { in: %w[present absent] }
end
