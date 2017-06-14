json.extract! lead, :id, :location, :email, :comment, :user_id, :processed, :created_at, :updated_at
json.url lead_url(lead, format: :json)
