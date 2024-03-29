class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token
	has_secure_password
	has_many :projects, dependent: :destroy
	validates :name, presence: true, length: { maximum: 30 }
	validates :username, presence: true, length: { maximum: 20 }, uniqueness: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private 

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
		
	
	
end
