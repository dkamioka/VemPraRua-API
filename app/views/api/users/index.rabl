object false
node(:total) { |m| @users.count }
child (@users) { attributes :id, :latitude, :longitude }
