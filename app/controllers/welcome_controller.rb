class WelcomeController < ApplicationController
  require 'pp'
  
  def splash
    #@book_info = Books.getBookByIsbn("0824828917")
    #@book_prices = Books.getPricesByIsbn("0824828917")
    
    render :splash
  end
  
  def results
    @search_pages = Books.getSearchPages("computer engineering")
    @books = @search_pages["page"]["results"]["book"]
  end
  
  def beer_me
    @book_prices = Books.getBuybackInfoByIsbn("0824828917")
    @merchants = @book_prices["page"]["offers"]["merchant"]
  end
end
