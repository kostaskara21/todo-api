class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  

    # return auth token once user is authenticated
    def authenticate
      auth_token =
        AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
      json_response(auth_token: auth_token)
      
    end
  

    def logout
      token = request.headers['Authorization']&.split(' ')&.last  # Extract the token from Authorization header
      if token
        REDIS.sadd("blacklisted_tokens", token)  # Add the token to the Redis set "blacklisted_tokens"
        REDIS.expire("blacklisted_tokens", 24.hours.to_i)
        json_response({ message: Message.log_out }, :ok)
      end
    end


    private
  
    def auth_params
      params.permit(:email, :password)
    end

    
  end