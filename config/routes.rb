Rails.application.routes.draw do

  get 'builds/new'

  root 'static_pages#menu'
  
  get 'static_pages/menu'

  resources :museum_objects do
    resources :builds
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
