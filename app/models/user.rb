class User < ActiveRecord::Base
  attr_accessible :fbuid, :fbat, :latitude, :longitude, :name, :regid
  has_many :locations 

  def last_online(horas=1)
    last = [] 
    User.where('updated_at > ?', Time.now - horas.hour).each { |x| last << x.id }
    last
  end


  def send_gcm_fullscreen(title,message)
    GCM.send_notification(self.regid, { code: 1, title: title, message: message}) if self.regid
  end


  def send_gcm_vemprarua(title,message,latitude,longitude,zoom = 8)
    GCM.send_notification(self.regid, { code: 2, title: title, message: message, latitude: latitude, longitude: longitude, zoom: zoom}) if self.regid
  end


end
