Beer4textbooks::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  match 'results' => 'welcome#results', :as => :buyback_search_results
  match 'beer_me' => 'welcome#beer_me', :as => :buyback_book_result
  
  match 'about' => 'about#about', :as => :about
  match 'whyus' => 'about#why', :as => :whyus
  match 'blog' => 'about#blog', :as => :blog
  
  match 'faq' => 'questions#faq', :as => :faq
  match 'customers' => 'questions#customers', :as => :customer_service
  
  match 'beginnings' => 'company#beginnings', :as => :beginnings
  match 'press' => 'company#press', :as => :press
  match 'feedback' => 'company#feedback', :as => :feedback
  match 'careers' => 'company#careers', :as => :careers
  match 'terms' => 'company#terms', :as => :terms
  match 'privacy' => 'company#privacy', :as => :privacy
  match 'sitemap' => 'company#sitemap', :as => :sitemap
  
  match 'sms_query' => 'welcome#sms_reply', :via => 'post'
  
  root :to => "welcome#splash"

end
