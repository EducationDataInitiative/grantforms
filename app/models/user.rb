class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :registerable, :recoverable, :rememberable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :remember_me, :mygov_access_token
  # attr_accessible :title, :body
  
  has_many :organizations
  has_many :grant_applications
  
  class << self
    
    def find_for_mygov_oauth(access_token, signed_in_resource = nil)
      user = User.find_or_create_by_mygov_uid(access_token.uid)
      user.update_attributes(:mygov_access_token => access_token.credentials.token, :email => access_token.info["email"])
      user
    end
  end
  
  def mygov_profile
    JSON.parse(mygov_client.get("/api/profile").body)["user"]
  end
  
  def submit_forms(data)
    mygov_client.post("/api/forms", :body => data[:sf_424])
  end
  
  private
  
  def mygov_client
    @mygov_client ||= OAuth2::Client.new(MYGOV_CLIENT_ID, MYGOV_SECRET_ID, :site => 'https://my.usa.gov', :token_url => "/oauth/authorize")
    self.mygov_access_token ? @mygov_token ||= OAuth2::AccessToken.new(@mygov_client, self.mygov_access_token) : nil
  end
end