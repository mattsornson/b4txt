class WelcomeController < ApplicationController
  require 'pp'
  
  def splash

  end
  
  def results
    if has_ref?
      @keywords = params[:q]
      if Books.isIsbn?(@keywords)
        redirect_to :action => :beer_me, :q => @keywords
      else
        @search_pages = Books.getSearchPages(@keywords)
        if @search_pages.nil?
          flash[:notice] = "Sorry, we drank too much beer and had an error."
          redirect_to :root
        else
          @books = @search_pages["page"]["results"]["book"]
        end
      end
    else
      send_home_error
    end
  end
  
  def beer_me
    if has_ref?
      @isbn = params[:q]
      if Books.isIsbn?(@isbn)
        @book_prices = Books.getBuybackInfoByIsbn(@isbn)
        @merchants = @book_prices["page"]["offers"]["merchant"]
      else
        send_home_error
      end
    else
      send_home_error
    end
  end
end
