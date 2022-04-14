Rails.application.routes.draw do
  get 'home/zipcode'
  get 'home/about'
  root 'home#index'

  post 'zipcode' => 'home/zipcode'
end 
