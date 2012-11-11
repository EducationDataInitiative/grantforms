class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :mygov_access_token
  # attr_accessible :title, :body
  
  has_many :organizations
  
  class << self
    
    def find_for_mygov_oauth(access_token, signed_in_resource = nil)
      user = User.find_or_create_by_mygov_uid(access_token.uid)
      user.update_attributes(:mygov_access_token => access_token.token, :email => access_token.info["email"])
      user
    end
  end
end
