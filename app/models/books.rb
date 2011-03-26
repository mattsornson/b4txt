class Books < ActiveRecord::Base
  include HTTParty
  
  def self.getBookByIsbn(isbn)
    book = HTTParty.get("http://api.campusbooks.com/11/rest/bookinfo",
      :query => {:isbn => isbn,
      :image_height => 100, :image_width => 80,
      :format => 'json', :key => API_KEY})["response"]
  end
  
  def self.getPricesByIsbn(isbn)    
    prices = HTTParty.get("http://api.campusbooks.com/11/rest/prices",
      :query => {:isbn => isbn,
      :format => 'json', :key => API_KEY})["response"]
  end
end
