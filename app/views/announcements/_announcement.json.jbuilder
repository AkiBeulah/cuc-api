json.extract! announcement, :id, :title, :subtitle, :body, :level, :department, :college, :hall, :program, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
