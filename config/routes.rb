Rails.application.routes.draw do
  
  namespace :admin do
      resources :museum_objects
      resources :excavation_sites
      resources :material_specifieds_koo_specs
      resources :museums
      resources :storages
      resources :storage_locations
      resources :termlist_acquisition_delivered_bies
      resources :termlist_acquisition_kinds
      resources :termlist_authenticities
      resources :termlist_colors
      resources :termlist_conservations
      resources :termlist_dating_centuries
      resources :termlist_dating_millennia
      resources :termlist_dating_periods
      resources :termlist_decorations
      resources :termlist_decoration_colors
      resources :termlist_decoration_techniques
      resources :termlist_excavation_site_categories
      resources :termlist_excavation_site_kinds
      resources :termlist_inscription_languages
      resources :termlist_inscription_letters
      resources :termlist_kind_of_objects
      resources :termlist_kind_of_object_specifieds
      resources :termlist_materials
      resources :termlist_material_specifieds
      resources :termlist_preservation_materials
      resources :termlist_preservation_objects
      resources :termlist_production_techniques

      root to: "museum_objects#index"
    end
  get 'termlists/index'
  get 'termlists/choose'
  get 'termlists/show'

  root 'static_pages#menu'
  get 'builds/new'
  get 'static_pages/menu'

  get 'museum_objects/search' # remember that orders matter
  resources :museum_objects do
    resources :builds
    post 'builds/step_confirm', to: 'builds#create'
  end
  
  delete 'image_list/:id/image/:image_id', to: 'museum_object_image_lists#delete_image', as: 'delete_image'
  
  
  # Helper actions for ajax call to find correct action
  get 'builds/storagess', to: "builds#storages"
  get 'builds/storage_locations', to: "builds#storage_locations"
  get 'builds/excavation_site_kinds', to: "builds#excavation_site_kinds"
  get 'builds/kind_of_objects_for_spec_material', to: "builds#kind_of_objects_for_spec_material"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
