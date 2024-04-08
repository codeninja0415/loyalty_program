class Point < ApplicationRecord
  belongs_to :user
  belongs_to :related_transaction, class_name: 'Transaction'  
end
