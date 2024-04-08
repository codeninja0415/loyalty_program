json.extract! user, :id, :name, :email, :password_digest, :loyalty_tier, :created_at, :updated_at
json.url user_url(user, format: :json)
