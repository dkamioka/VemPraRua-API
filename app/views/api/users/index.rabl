object false
node(:total) { |m| @users.count }
child(@users, object_root: false) { attributes :id, :name, :status, :latitude, :longitude }

