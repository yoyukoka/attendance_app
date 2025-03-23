class Attendance < ApplicationRecord # rubocop:disable Style/Documentation
  belongs_to :event
  belongs_to :user

  validates :status, inclusion: { in: %w[出席 欠席] }
end
