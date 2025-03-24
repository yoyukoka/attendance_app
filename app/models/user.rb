class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances

  validates :name, presence: true, on: :update
  validates :position, presence: true, on: :update

  enum position:
    {
      PR: 'PR',
      HO: 'HO',
      LO: 'LO',
      FL: 'FL',
      No8: 'No8',
      SH: 'SH',
      SO: 'SO',
      CTB: 'CTB',
      WTB: 'WTB',
      FB: 'FB'
    }

  def attendance_rate
    total_events = Event.count
    attended_events = attendances.where(status: 'present').count
    total_events.zero? ? 0 : (attended_events.to_f / total_events * 100).round(2)
  end
end
