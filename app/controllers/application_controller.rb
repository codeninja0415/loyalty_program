class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token
    private

    def authenticate_user!
        token = request.headers['Authorization']&.split(' ')&.last
        user = User.new  
        decoded_token = user.decode_token(token)
        render json: { error: 'Invalid token' }, status: :unauthorized unless decoded_token
    end
    
   


  def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    user = User.new 
    decoded_token = user.decode_token(token)  
    return nil unless decoded_token

    user_id = decoded_token[0]['user_id']  
    User.find(user_id)  
  rescue ActiveRecord::RecordNotFound
    nil 
  end
end
