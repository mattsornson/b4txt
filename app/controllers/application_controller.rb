class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :has_ref?, :send_home_error
  
  protected
    def has_ref?
      not(params[:q].nil?)
    end
    
    def send_home_error
      flash[:notice] = "You need to search for your books before you can sell them for beer."
      redirect_to :root
    end
end
