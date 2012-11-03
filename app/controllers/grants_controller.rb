class GrantsController < ApplicationController
  # Requires that the user be signed in to edit
  before_filter :authenticate_user!, only: [:edit, :update]
  
  def new
    @grant = Grant.new
  end
  
  def show
    @grant = Grant.find(params[:id])
  end
  
  def create
      @grant = Grant.new(params[:grant])
      if @grant.save
        redirect_to @grant
      else
        render 'new'
      end
  end
  
  def index
    # For Ransack search
    @q = Grant.search(params[:q])
    @grants = @q.result(:distinct => true).paginate(page: params[:page])
  end
  
  def edit
    @grant = Grant.find(params[:id])
  end
  
  def update
     @grant = Grant.find(params[:id])
     if @grant.update_attributes(params[:grant])
       redirect_to @grant, :flash => { :success => "Grant updated." }
     else
       render 'edit'
     end
   end
  
end