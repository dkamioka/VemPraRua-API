class User < ActiveRecord::Base
  attr_accessible :fbuid, :fbat, :latitude, :longitude, :name, :regid
  has_many :locations 

  def last_online(horas=1)
    last = [] 
    User.where('updated_at > ?', Time.now - horas.hour).each { |x| last << x.id }
    last
  end

end
