class Books < ActiveRecord::Base

  def self.getBookByIsbn(isbn)
    book = HTTParty.get("http://api.campusbooks.com/11/rest/bookinfo",
      :query => {:isbn => isbn,
        :image_height => '100', :image_width => '80',
        :format => 'xml', :key => API_KEY})["response"]
  end
  
  def self.getPricesByIsbn(isbn)
    prices = HTTParty.get("http://api.campusbooks.com/11/rest/prices",
      :query => {:isbn => isbn,
        :format => 'xml', :key => API_KEY})["response"]
  end
  
  def self.getSearchPages(keywords)
    begin
      pages = HTTParty.get("http://api.campusbooks.com/11/rest/search",
        :query => {
          :keywords => keywords,
          :image_height => '100', :image_width => '80',
          :format => 'xml', :key => API_KEY})["response"]
    rescue Crack::ParseError => e
      nil
    end
  end
  
  def self.getSearchPage(keywords, page)
    page = HTTParty.get("http://api.campusbooks.com/11/rest/search",
      :query => {
        :keywords => keywords, 
        :page => page, :image_height => '100', :image_width => '80',
        :format => 'xml', :key => API_KEY})["response"]
  end

  def self.getBuybackInfoByIsbn(isbn)
    price = HTTParty.get("http://api.campusbooks.com/11/rest/buybackprices",
      :query => {:isbn => isbn,
        :image_width => 200,
        :format => 'xml', :key => API_KEY})["response"]
  end
  
  def self.isIsbn?(input)
    input = input.tr('-', '')
    input = input.tr('x', '')
    input = input.tr('X', '')
    
    true if Float(input) rescue false
  end
end
