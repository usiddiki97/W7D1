# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :password, length: {minimum: 6}, allow_nil: true
    validates :password_digest, presence: true
    validates :session_token, presence: true, uniqueness: true

    attr_reader :password
    
    after_initialize :ensure_session_token

    def reset_session_token!
        self.session_token = self.class.generate_session_token 
        self.save # don't forget to save! the new session token needs to end up in the database
        
        # return the new session_token for convenience
        self.session_token
    end

    def password=(password)
        @password = password
        # need to set @password so it can be returned by the password getter method, 
        # which is used for the minimum length validation (don't worry, won't be stored in db)
        self.password_digest = BCrypt::Password.create(password)
        # here, BCrypt's `create` takes a plaintext password, salts and hashes it, and returns a digest
    end

    def is_password?(password)
        # self.password_digest is just a string, so we first convert it to a bcrypt object
        bpassword = BCrypt::Password.new(self.password_digest) 

        # here we use the BCrypt `is_password?`, an entirely different method from the one we're writing here 
        bpassword.is_password?(password) 
    end

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        return nil unless user && user.is_password?(password)
        user
    end

    private
    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end
    
end
