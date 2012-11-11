class ApplicationController < ActionController::Base
  protect_from_forgery

  def assign_user
    @user = current_user
  end
end
