class User < ActiveRecord::Base
  attr_accessible :fbuid, :latitude, :longitude, :name, :regid, :ip_address
  has_many :locations 

  def self.last_online(horas=1)
    last = [] 
    User.where('updated_at > ?', Time.now - horas.hour).each { |x| last << x.id }
    last
  end

end
