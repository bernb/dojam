Rails.application.routes.draw do

  root 'static_pages#menu'
  
  get 'static_pages/menu'

  resources :museum_objects

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
