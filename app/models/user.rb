class User < ActiveRecord::Base
  attr_accessible :fbuid, :latitude, :longitude, :name, :regid
end
