class Api::VersionsController < ApplicationController
  def last
    @result = { :version => ENV['APP_VERSION'], :url => ENV['APP_URL'] }
  end
end
