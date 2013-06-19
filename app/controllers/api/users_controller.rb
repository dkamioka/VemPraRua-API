class Api::UsersController < ApplicationController
  def create
    @user = User.create(params[:user])
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.update_attributes(params[:user]) if @user
  end

  def show
    @user = User.find_by_id(params[:id])
  end

end
