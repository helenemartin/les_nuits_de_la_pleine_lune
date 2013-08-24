class LocalesController < ApplicationController
  def show
    session[:locale] = params[:id]
    
    
    redirect_to root_path
  end
end
