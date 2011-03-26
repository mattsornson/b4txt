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
      if params[:brand].nil?
        @beer_brand = "coors"
      else
        @beer_brand = params[:brand]
      end
      
      if Books.isIsbn?(@isbn)
        @book_prices = Books.getBuybackInfoByIsbn(@isbn)
        @merchants = @book_prices["page"]["offers"]["merchant"]
        @prices = {}
        @merchants.each do |m|
          @prices[m["merchant_id"]] = Beer.getPriceInBeers(@beer_brand, m["prices"]["price"][0])
        end
      else
        send_home_error
      end
    else
      send_home_error
    end
  end
  
  def sms_reply
    @isbn = params[:Body]
    @from = params[:From]
    
    if not(@isbn.nil?)
      if Books.isIsbn?(@isbn)
        
        @price = Books.getBuybackInfoByIsbn(@isbn)["page"]["offers"]["merchant"][0]["prices"]["price"][0]
        @beer_price = Beer.getPriceInBeers("miller", @price)
        
        @price_string = @beer_price["kegs"].to_s + " kegs, " +
     			 		@beer_price["cases"].to_s + " cases, " + 
     					@beer_price["bottles"].to_s + " bottles"
        
        account = Twilio::RestAccount.new(TWILIO_API_KEY, TWILIO_API_SECRET)
        d = { 'From' => TWILIO_NUMBER, 'To' => @from,
              'Body' => (@price_string) }
        resp = account.request("/#{TWILIO_VERSION}/Accounts/#{TWILIO_API_KEY}/SMS/Messages", 'POST', d)
        resp.error! unless resp.kind_of? Net::HTTPSuccess
        logger.info "### INFO ### Twilio error: " + resp.code
      end
    end
  end
end
