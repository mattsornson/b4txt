class Beer < ActiveRecord::Base
  
  BEER_PRICES = {}
  BEER_PRICES['keystone'] = {:keg => 60.99, :case => 13.98, :bottle => 1.17}
  BEER_PRICES['bud'] = {:keg => 86.99, :case => 14.99, :bottle => 1.25}
  BEER_PRICES['coors'] = {:keg => 86.99, :case => 17.98, :bottle => 1.50}
  BEER_PRICES['miller'] = {:keg => 86.99, :case => 17.98, :bottle => 1.50}
  BEER_PRICES['heineken'] = {:keg => 112.99, :case => 26.99, :bottle => 2.25}
  BEER_PRICES['guinness'] = {:keg => 112.99, :case => 26.99, :bottle => 2.25}
  BEER_PRICES['sam_adams'] = {:keg => 86.99, :case => 17.98, :bottle => 1.50}
  
  def self.getPriceInBeers(brand, cost)
    price = {}
    cost = cost.to_f
    
    price['kegs'] = (cost / BEER_PRICES[brand][:keg]).to_i
    cost = cost - price['kegs'] * BEER_PRICES[brand][:keg]
    
    price['cases'] = (cost / BEER_PRICES[brand][:case]).to_i
    cost = cost - price['cases'] * BEER_PRICES[brand][:case]
    
    price['bottles'] = (cost / BEER_PRICES[brand][:bottle]).to_i
    
    price
  end
end
