class GrantApplicationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :assign_user
  before_filter :assign_grant, :except => [:index]
  before_filter :assign_grant_application, :except => [:index, :new, :create]
  
  def index
    @grant_applications = @user.grant_applications
  end
  
  def new
    @grant_application = @user.grant_applications.new
  end
  
  def create
    @grant_application = @user.grant_applications.new(params[:grant_application])
    @grant_application.organization.user_id = @user.id if @grant_application.organization
    @grant_application.grant = @grant
    if @grant_application.save
      flash[:notice] = "Successfully created application"
      redirect_to grant_application_contact_info_path(@grant, @grant_application)
    else
      flash[:error] = "There was a problem creating your application"
      render :new
    end
  end
  
  def contact_info
    @profile = @user.mygov_profile
  end
  
  def page_2
  end
  
  def page_3
  end
  
  def review
  end
  
  def update
    @grant_application.data = {} if @grant_application.data.nil?
    @grant_application.data.merge!(params[:grant_application][:data] || {})
    if @grant_application.save
      redirect_to next_grant_application_action_paths(params[:grant_application_page])
    else
      flash[:error] = "There was a problem updating your information."
      render params[:action]
    end
  end
  
  def finish
    if @grant_application.submit_to_mygov
      flash[:notice] = "You're grant application has been submitted."
    else
      flash[:error] = "There was a problem submitting your grant."
    end
  end
  
  private
  
  def assign_grant
    @grant = Grant.find(params[:grant_id])
  end
  
  def assign_grant_application
    @grant_application = GrantApplication.find(params[:application_id] || params[:id])
  end
  
  def next_grant_application_action_paths(current_action)
    case current_action
    when "contact_info"
      grant_application_page_1_path(@grant, @grant_application)
    when "page_1"
      grant_application_page_2_path(@grant, @grant_application)
    when "page_2"
      grant_application_page_3_path(@grant, @grant_application)
    when "page_3"
      grant_application_review_path(@grant, @grant_application)
    end
  end
end