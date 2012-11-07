class GrantsController < ApplicationController
  
  def index
    @q = Grant.search(params[:q])
    @grants = @q.result(:distinct => true).paginate(page: params[:page])
  end
  
  def show
    @grant = Grant.find(params[:id])
  end  
end