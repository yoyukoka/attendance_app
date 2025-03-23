class Attendance < ApplicationRecord # rubocop:disable Style/Documentation
  belongs_to :event
  belongs_to :user

  validates :status, inclusion: { in: %w[present absent] }
end
