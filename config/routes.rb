Rails.application.routes.draw do

  get 'builds/new'

  root 'static_pages#menu'
  
  get 'static_pages/menu'

  resources :museum_objects do
    resources :builds
  end
  
  # Helper actions for ajax call to get correct storage(_location)s for selected museum/storage
  get 'builds/storagess', to: "builds#storages"
  get 'builds/storage_locations', to: "builds#storage_locations"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
