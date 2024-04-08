class User < ApplicationRecord
    has_secure_password
    has_many :points
    has_many :rewards, through: :transactions 
    def encode_token(payload)
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
    def decode_token(token)
        JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
    end

    def update_points_and_expiration
      today = Date.today
      if last_expiration.nil? || last_expiration.year < today.year
        @points = Point.wher(user: self)
        @points.update(is_deleted:true)
      end
    end
  
    def update_tier
      end_date = Date.today.end_of_day
      start_date = end_date - 6.months
      max_points = self.points.where(created_at: [start_date..end_date]).collect(&:points).compact.inject(:+).to_f
      p max_points
      self.loyalty_tier = case max_points
        when 10000..Float::INFINITY then 2
        when 5000..9999 then 1
        else 0
        end
        p self.loyalty_tier
      save!
    end
  
    def update_bonus
        if qualifying_quarterly_transactions(2000)
            Point.create(user: self, points: 100)
        end
    end
  
    def qualifying_quarterly_transactions(threshold)
      today = Date.today
      quarter = (today.month / 3.0).ceil
      year = today.year 
      quarter = quarter.clamp(1, 4)

      start_date = Date.new(year, quarter * 3 - 2, 1)  
      end_date = start_date.end_of_month
    
      self.points.where(created_at: [start_date..end_date]).collect(&:points).compact.inject(:+).to_f > threshold
     
    end
end

