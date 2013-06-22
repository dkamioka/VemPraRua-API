class Api::UsersController < ApplicationController

  def create
    fbuid = params[:user][:fbuid]
    @user = User.find_by_fbuid(fbuid) if fbuid
    if @user
      @user.update_attributes(params[:user])
    else
      @user = User.create(params[:user])
      if !user.name
        @user.name = "Anonymous \# #{@user.id}"
      end
      @user.ip_address = env['HTTP_X_REAL_IP'] ||= env['REMOTE_ADDR']
      if params[:user][:latitude].nil?
        set_coordinates_by_ip
      end
      @user.save
    end
  end

  def update
    if (@user = User.find_by_id(params[:id])) 
    @user.update_attributes(params[:user])
    @user.ip_address = env['HTTP_X_REAL_IP'] ||= env['REMOTE_ADDR']
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

  def last_ids
    @last_ids = User.last_online(params[:hora])
  end

  protected
  def set_current_ip
    User.ip_address = env['HTTP_X_REAL_IP'] ||= env['REMOTE_ADDR']
  end

  def set_coordinates_by_ip
    puts "\n\n Vai tentar setar o lat e long atraves do ip \n\n"
    loc = Location.new
    loc.latitude = request.location.latitude
    loc.longitude = request.location.longitude
    puts "Saida do geocoder:\n", @user.latitude, @user.longitude = loc.latitude, loc.longitude    
    @user.latitude, @user.longitude = loc.latitude, loc.longitude    
    @user.locations << loc
  end
end
