require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  # Authentication test suite
  describe 'POST /auth/login' do
    # create test user
    let!(:user) { create(:user) }
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # set request.headers to our custon headers
    # before { allow(request).to receive(:headers).and_return(headers) }

    # returns auth token when request is valid
    context 'When request is valid' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    # returns failure message when request is invalid
    context 'When request is invalid' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'returns a failure message' do
        expect(json['message']).to match(/Invalid credentials/)
      end
    end
  end



  #Test for the logout 
  describe 'GET auth/logout' do 
    # create test user
    let!(:user) { create(:user) }
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    
    
    # returns failure message when no Authorizatin token is provided 
    context 'When  no Authorizatin is rovided ' do
      before { get '/auth/logout', params:{}, headers: {} }
      it 'Missing token ' do
        expect(json['message']).to match(/Missing token/)
        
      end
    end


    #returns success message when user is successfully logoing out 
    context 'When token is valid and the user successfully login out' do
      let!(:user) { create(:user) }
      let(:token) { JsonWebToken.encode(user_id: user.id) }  
      let(:valid_headers) { { "Authorization" => "Bearer #{token}" } }   
      before {get '/auth/logout',params:{},headers:valid_headers}
      it 'loged out successfully' do 
        expect(response).to have_http_status(200)
        expect(json["message"]).to match(/Logged out successfully/)
      end
    end


    #returns failure message when user gives wrong value to the token  
    context 'When invalid token is provided with the right format but wrong value' do 
      let(:invalid_headers) { { "Authorization" => "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE3NDA1MDY3MDF9.ephOwmsHeroqKDZ5CMsz8hnTX-WPJ9hp_r_OEVxIggg" } }
      before { get '/auth/logout', params:{}, headers: invalid_headers }
      it 'Invalid token' do 
        expect(response).to have_http_status(422)
        expect(json['message']).to match(/Signature verification failed/)
      end 
    end 

    #returns failure message when user is providing the token but its too short or too big 
    context 'When invalid token is provided being too short or having too many  segments' do 
      let(:invalid_headers) { { "Authorization" => "invalid_token" } }
      before { get '/auth/logout', params:{}, headers: invalid_headers }
      it 'Invalid token' do 
        expect(response).to have_http_status(422)
        expect(json['message']).to match(/Not enough or too many segments/)
      end 
    end 
    

    #returns failure message when user is providing a blacklisted  token 
    context 'When blacklisted token is provided' do
      before do
        token = JsonWebToken.encode(user_id: user.id)
        # Blacklist the token by storing its JTI in Redis      
        redis = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')
        redis.sadd("blacklisted_tokens", token)  # Add the token to the Redis set "blacklisted_tokens"
        # Prepare headers with the valid token (which has been blacklisted)
        @headers = { "Authorization" => "Bearer #{token}" }
      end
      it 'returns message that the token has already been blacklisted' do
        # Make the logout request with the blacklisted token
        get '/auth/logout', params: {}, headers: @headers
        # Assert that the response has HTTP status 403 (Forbidden) for blacklisted tokens
        expect(response).to have_http_status(403)
        expect(json['message']).to match(/This token has been blacklisted and cannot be used./)
      end
    end

    
    

  end

end