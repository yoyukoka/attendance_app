json.extract! event, :id, :title, :date, :details, :created_at, :updated_at
json.url event_url(event, format: :json)
