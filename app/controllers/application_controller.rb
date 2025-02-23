class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler

    #this is the exception for the blacklist token 
    #rescue_from ExceptionHandler::TokenBlacklisted, with: :token_blacklisted

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
  
 
  end