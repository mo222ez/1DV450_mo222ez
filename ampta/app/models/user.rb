class User < ActiveRecord::Base
	attr_accessible :email, :first_name, :last_name, :password, :password_confirmation
	
	has_many :tickets
	has_and_belongs_to_many :projects

	has_secure_password

	validates_presence_of :email
	validates_uniqueness_of :email

	validates_presence_of :password, :on => :create
	validates_presence_of :password_confirmation, :on => :create

	def self.authenticate(password)
		find_by_email(email).try(:authenticate, password)
	end
end
