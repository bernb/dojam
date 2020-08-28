Rails.application.routes.draw do
  
  get 'users/index'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
#  get 'termlists/index'
#  get 'termlists/choose'
#  get 'termlists/show'
  resources :termlists
  resources :loan_outs
  resources :users

# Reports from reports_kit
  mount ReportsKit::Engine, at: '/'

  root 'static_pages#menu'
  get 'static_pages/reports'
  get 'builds/new'
  get 'static_pages/menu'

  get 'museum_objects/search' # remember that orders matter
  get 'museum_objects/search_result_invnumber'
  get 'museum_objects/search_form'
  get 'museum_objects/add_search_field'
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
