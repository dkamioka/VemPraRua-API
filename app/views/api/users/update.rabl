object @user
attributes :id, :name, :status, :source, :latitude, :longitude
node :errors do | o |
  o.errors
end
