class WelcomeController < ApplicationController
  require 'pp'
  
  def splash
    @book_info = Books.getBookByIsbn("0824828917")
    #@book_prices = Books.getPricesByIsbn("0824828917")
    
    render :splash
  end
end
