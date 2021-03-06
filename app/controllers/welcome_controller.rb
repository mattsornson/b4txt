class WelcomeController < ApplicationController
  require 'pp'
  require 'bitly'
  
  layout 'twopointoh'
  
  def splash
    render :index
  end
  
  def results
    if has_ref?
      @keywords = params[:q]
      @brand = params[:brand]
      if Books.isIsbn?(@keywords)
        @isbn = @keywords.tr('-', '').tr('x', '').tr('X', '')
        save_query
        redirect_to :action => :beer_me, :q => @isbn, :brand => @brand
      else
        @search_pages = Books.getSearchPages(@keywords)
        if @search_pages.nil?
          flash[:notice] = "Sorry, we drank too much beer and had an error."
          redirect_to :root
        elsif @search_pages["page"]["count"] == '1'
          @isbn = @search_pages["page"]["results"]["book"]["isbn10"]
          save_query
          redirect_to :action => :beer_me, :q => @isbn, :brand => @brand
        else
          if @search_pages["page"].nil? or @search_pages["page"]["results"].nil?
            no_book_error
            return
          end
          save_query
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
      if params[:brand].nil?
        @beer_brand = "coors"
      else
        @beer_brand = params[:brand]
      end
      
      if Books.isIsbn?(@isbn)
        @isbn = @isbn.tr('-', '').tr('x', '').tr('X', '')
        
        @book = Books.getBookByIsbn(@isbn)
        @book_prices = Books.getBuybackInfoByIsbn(@isbn)
        if @book_prices["page"].nil?
          no_merchants_error
          return
        end
        @merchants = @book_prices["page"]["offers"]["merchant"]
        @prices = {}
        if @merchants.nil?
          no_merchants_error
          return
        else
          @merchants.each do |m|
            begin
              @prices[m["merchant_id"]] = Beer.getPriceInBeers(@beer_brand, m["prices"]["price"][0].to_i) 
            rescue TypeError
              send_home_error
              return
            end
          end
        end
      else
        send_home_error
        return
      end
    else
      send_home_error
      return
    end
  end
  
  def sms_reply
    @isbn = params[:Body]
    @from = params[:From]
    
    if not(@isbn.nil?)
      if Books.isIsbn?(@isbn)
        
        @isbn = @isbn.tr('-', '').tr('x', '').tr('X', '')
        
        logger.info @isbn
        logger.info @from
        
        @price = Books.getBuybackInfoByIsbn(@isbn)
        @price_single = @price["page"]["offers"]["merchant"][0]["prices"]["price"][0]
        @beer_price = Beer.getPriceInBeers("miller", @price_single)
        
        logger.info @beer_price
        
        @price_string = @beer_price["kegs"].to_s + " kegs, " +
     			 		@beer_price["cases"].to_s + " cases, " + 
     					@beer_price["bottles"].to_s + " bottles"
     					
     		logger.info @price_string
     		
     		bitly = Bitly.new(BITLY_USERNAME, BITLY_API_KEY)
     		page_url = bitly.shorten(@price["page"]["offers"]["merchant"][0]["link"])
        
        account = Twilio::RestAccount.new(TWILIO_API_KEY, TWILIO_API_SECRET)
        d = { 'From' => TWILIO_NUMBER, 'To' => @from,
              'Body' => (@price_string + " " + page_url.shorten) }
        resp = account.request("/#{TWILIO_VERSION}/Accounts/#{TWILIO_API_KEY}/SMS/Messages", 'POST', d)
        resp.error! unless resp.kind_of? Net::HTTPSuccess
        logger.info "### INFO ### Twilio error: " + resp.code
      end
    end
  end
  
  def about

  end
end
