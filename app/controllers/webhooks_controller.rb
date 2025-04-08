class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session

  def callback
    body = request.body.read
    events = JSON.parse(body)['events']

    events.each do |event|
      # グループにBotが追加された場合
      next unless event['type'] == 'join'

      group_id = event['source']['groupId']
      Rails.logger.info("Bot added to group: #{group_id}")
      # 必要に応じてグループIDを保存
    end

    head :ok
  end
end
