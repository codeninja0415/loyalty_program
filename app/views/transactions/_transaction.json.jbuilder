json.extract! transaction, :id, :user_id, :amount, :currency, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
