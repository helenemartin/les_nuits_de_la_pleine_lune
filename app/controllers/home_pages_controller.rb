class HomePagesController < ApplicationController
  def index
  	@moon = Moon.new 
    @phase = @moon.phase
    @user = User.new
  end
end
