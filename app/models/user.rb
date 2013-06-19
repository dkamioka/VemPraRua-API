class User < ActiveRecord::Base
  attr_accessible :fbuid, :latitude, :longitude, :name, :regid
  has_many :locations 
end
