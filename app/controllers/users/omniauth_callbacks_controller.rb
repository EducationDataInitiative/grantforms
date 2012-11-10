class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token, :only => [:mygov]
  
  def mygov
    @user = User.find_for_mygov_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "MyGov") if is_navigational_format?
    else
      session["devise.mygov_data"] = request.env["omniauth.auth"]
      redirect_to :back
    end
  end
end
