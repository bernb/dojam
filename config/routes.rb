Rails.application.routes.draw do
  
  namespace :admin do
      resources :museum_objects
      resources :museum_object_image_lists
      resources :termlists
      resources :color_museum_objects
      resources :excavation_sites
      resources :excavation_site_category_kinds
      resources :material_museum_objects
      resources :material_specified_museum_objects
      resources :museums
      resources :museum_object_paths
      resources :paths
      resources :storages
      resources :storage_locations
      resources :termlist_paths
      resources :acquisition_delivered_bies
      resources :acquisition_kinds
      resources :authenticities
      resources :colors
      resources :dating_centuries
      resources :dating_millennia
      resources :dating_periods
      resources :decorations
      resources :decoration_colors
      resources :decoration_techniques
      resources :excavation_site_categories
      resources :excavation_site_kinds
      resources :inscription_languages
      resources :inscription_letters
      resources :kind_of_objects
      resources :kind_of_object_specifieds
      resources :materials
      resources :material_specifieds
      resources :preservation_materials
      resources :preservation_objects
      resources :priorities
      resources :production_techniques

      root to: "excavation_sites#index"
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
  get 'builds/kind_of_objects_for_spec_material_path', to: "builds#kind_of_objects_for_spec_material_path"

	# importer actions
	get  '/import_termlists/select', to: 'static_pages#import_termlists_select'
	post '/import_termlists/submit', to: 'static_pages#import_termlists_submit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
