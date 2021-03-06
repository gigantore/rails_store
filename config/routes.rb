Store::Application.routes.draw do
  
  devise_for :admins
  
  resources :baskets do
    resources :line_items
  end

  resources :categories
  
  resources :items do
    collection do
      post 'search'
    end
    resources :item_options
  end
  
  resources :pages
  
  resources :payment_notifications, :only => [:create]
  
  root :to => 'items#recent'
  
end