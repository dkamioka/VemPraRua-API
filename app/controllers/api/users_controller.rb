class Api::UsersController < ApplicationController
  def create
    @user = User.create(params[:user])
    @user.name = "Anonymous \# #{@user.id}"
    @user.save
  end

  def update
    if (@user = User.find_by_id(params[:id])) 
    @user.update_attributes(params[:user])
    @user.location.latitude = params[:user][:latitude]
    @user.location.longitude = params[:user][:longitude]
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
