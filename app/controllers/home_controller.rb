class HomeController < ApplicationController
  def index
    @users = Users.all
  end
end
