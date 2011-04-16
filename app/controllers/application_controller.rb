class ApplicationController < ActionController::Base
  include Facebooker2::Rails::Controller
  
  protect_from_forgery
  
  helper_method :has_ref?, :send_home_error, :no_book_error, :no_merchants_error
  
  protected
    def has_ref?
      not(params[:q].nil? or params[:q].empty?)
    end
    
    def send_home_error
      flash[:notice] = "You need to search for your books before you can sell them for beer."
      redirect_to :root
    end
    
    def no_book_error
      flash[:notice] = "No results found. Were you drunk while you typed the ISBN?"
      redirect_to :root
    end
    
    def no_merchants_error
      flash[:notice] = "Nobody wants your book. Try something else."
      redirect_to :root
    end
end
