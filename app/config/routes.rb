Rails.application.routes.draw do
  
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

  # CRUDs
  resources :acquisition_delivered_bies

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
