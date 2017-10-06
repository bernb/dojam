Rails.application.routes.draw do
  
  root 'static_pages#menu'
  get 'builds/new'
  get 'static_pages/menu'

  get 'museum_objects/search' # remember that orders matter
  resources :museum_objects do
    resources :builds
    post 'builds/step_confirm', to: 'builds#create'
  end
  
  # Helper actions for ajax call to get correct storage(_location)s for selected museum/storage
  get 'builds/storagess', to: "builds#storages"
  get 'builds/storage_locations', to: "builds#storage_locations"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
