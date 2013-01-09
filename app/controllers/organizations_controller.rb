class OrganizationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :assign_user

  def index
    @organizations = @user.organizations
  end

  def new
    @organization = @user.organizations.new
  end

  def create
    @organization = @user.organizations.new(params[:organization])
    if @organization.save
      flash[:notice] = "Successfully created organization"
      redirect_to organization_path(@organization)
    else
      flash[:error] = "There was a problem creating your orgranization"
      render :new
    end
  end

  def show
    @organization = @user.organizations.find_by_duns(params[:id])
  end

  def edit
    @organization = @user.organizations.find_by_duns(params[:id])
  end

  def update
    @organization = @user.organizations.find_by_duns(params[:id])
    if @organization and @organization.update_attributes(params[:organization])
      flash[:notice] = "Successfully updated organization"
      redirect_to params["redirect_to"] || organization_path(@organization)
    else
      flash[:error] = "There was a problem updating your organization"
      render :edit
    end
  end

  def destroy
    @organization = @user.find_by_duns(params[:id])
    if @organization.destroy
      flash[:notice] = "Successfully delete organization"
      redirect_to organizations_path
    else
      flash[:error] = "Unable to delete organization"
      redirect_to :back
    end
  end
end