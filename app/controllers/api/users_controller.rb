class Api::UsersController < ApplicationController

  def create
    @user = User.create(params[:user])
    @user.name = "Anonymous \# #{@user.id}"
    @user.save
  end

  def update
    if (@user = User.find_by_id(params[:id])) 
    @user.update_attributes(params[:user])

=begin
     Aqui comeca uma verificacao de latlong. Nao vai inserir uma nova location se nao tiver mudado o suficiente de lugar.
     No caso, suficiente aqui foi 0.0002 de diferenca entre as latitudes e longitudes.
     Existe um BUG, onde ja que eu faco diferencas entre modulos, se o cara apareceu no exato oposto,
     digamos saiu de lat,long= -23,-46 para lat,long 23,46
     Como a diferenca e calculada por modulos/absolutos ele nao detecta. 
     Entretanto vou tratar como Know Issue. :P
     diogo.kamioka
=end

    new_lat, new_long = params[:user][:latitude].to_f, params[:user][:longitude].to_f
    old_loc = @user.locations.last
      unless old_loc.nil?
        old_lat, old_long = old_loc.latitude, old_loc.longitude
      else 
        old_lat, old_long = 0.0, 0.0
      end

        if ((new_lat.abs - old_lat.abs).abs + (new_long.abs - old_long.abs).abs > 0.0002 )
          loc = Location.new
          loc.latitude = new_lat
          loc.longitude = new_long
          @user.locations << loc
          @user.save
        end
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def index
    #@users = User.where("updated_at > ?", Time.now - 1.hour)
    @users = User.all
  end
end
