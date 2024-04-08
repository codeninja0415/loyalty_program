class AuthenticationController < ApplicationController
    protect_from_forgery with: :null_session 

    skip_before_action :authenticate_user!, only: :login
    
    def login
        email = params[:email]
        password = params[:password]
      
        user = User.find_by(email: email)
        # byebug  
        if user&.authenticate(password)
          payload = { user_id: user.id }
          token = user&.encode_token(payload)
          render json: { token: token }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end
end
