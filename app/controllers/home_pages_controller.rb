class HomePagesController < ApplicationController
  def index
  	@moon = Moon.new 
  end
end
