class User < ApplicationRecord

    # encrypt password(method provided by rails using bcrypt)
    has_secure_password

    #for model associations
    has_many:todos ,foreign_key: :created_by

    #for validations 
  validates_presence_of :name, :email, :password_digest
end
