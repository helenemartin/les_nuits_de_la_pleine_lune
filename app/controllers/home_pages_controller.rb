class HomePagesController < ApplicationController
  def index
  	@moon = Moon.new
  	
  	unless @moon.phase == :full
  	  render text: "not allowed" and return
  	end
  end
end
