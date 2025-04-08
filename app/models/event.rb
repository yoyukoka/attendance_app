require 'httparty'

class Event < ApplicationRecord
  after_create :notify_line
  has_many :attendances, dependent: :destroy
  has_many :users, through: :attendances

  validates :title, presence: true
  validates :date, presence: true

  private

  def notify_line
    return unless ENV['LINE_CHANNEL_ACCESS_TOKEN']

    url = 'https://api.line.me/v2/bot/message/push'
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{ENV['LINE_CHANNEL_ACCESS_TOKEN']}"
    }
    body = {
      to: 'U0fbb857406a0d68521ddc7d28c94b2c3',
      messages: [
        {
          type: 'text',
          text: "新しいイベントが作成されました！\nタイトル: #{title}\n日時: #{date}\n詳細: #{details}\nlink: #{ENV['HOMEPAGE_LINK']}"
        }
      ]
    }

    response = HTTParty.post(url, headers: headers, body: body.to_json)
    Rails.logger.info("LINE Notify Response: #{response.body}")
  end
end
