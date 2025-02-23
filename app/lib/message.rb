# app/lib/message.rb
class Message
    def self.not_found(record = 'record')
      "Sorry, #{record} not found."
    end
  
    def self.invalid_credentials
      'Invalid credentials'
    end
  
    def self.invalid_token
      'Invalid token'
    end
  
    def self.missing_token
      'Missing token'
    end
  
    def self.unauthorized
      'Unauthorized request'
    end
  
    def self.account_created
      'Account created successfully'
    end
  
    def self.account_not_created
      'Account could not be created'
    end
  
    def self.expired_token
      'Sorry, your token has expired. Please login to continue.'
    end

    #this is for the logout message for using a blacklisted token 
    def self.blackalisted_token
      'This token has been blacklisted and cannot be used.'
    end

    #this is for successfully logging out message
    def self.log_out
      'Logged out successfully'
    end

    
  end