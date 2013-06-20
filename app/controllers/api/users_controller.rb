class Api::UsersController < ApplicationController
  def create
    @user = User.create(params[:user])
    @user.name = "Anonymous \# #{@user.id}"
    @user.save
  end

  def update
    if (@user = User.find_by_id(params[:id])) 
    @user.update_attributes(params[:user])
    loc = Location.new
    loc.latitude = params[:user][:latitude]
    loc.longitude = params[:user][:longitude]
    @user.locations << loc
    @user.save
    end
    
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def index
    @users = User.all
  end
end
