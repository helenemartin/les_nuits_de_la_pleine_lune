class HomePagesController < ApplicationController
  def index
  	@moon = Moon.new 
    @phase = @moon.phase
  end
end
