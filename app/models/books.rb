class Books < ActiveRecord::Base

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
  
  def self.getSearchPages(keywords)
    pages = HTTParty.get("http://api.campusbooks.com/11/rest/search",
      :query => {
        :keywords => keywords,
        :image_height => 100, :image_width => 80,
        :format => 'json', :key => API_KEY})["response"]
  end
  
  def self.getSearchPage(keywords, page)
    page = HTTParty.get("http://api.campusbooks.com/11/rest/search",
      :query => {
        :keywords => keywords, 
        :page => page, :image_height => 100, :image_width => 80,
        :format => 'json', :key => API_KEY})["response"]
  end

end
