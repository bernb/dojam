Rails.application.routes.draw do
  
  #get 'users/index'
  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }
  # See https://github.com/heartcombo/devise/issues/4573 and
  # https://github.com/heartcombo/devise/issues/4470 for the reasoning. Note that
  # this problem is also related to turbolinks
  devise_scope :user do
    get '/users', to: 'devise/registrations#edit'
    get '/users/password', to: 'devise/passwords#new'
  end
  ActiveAdmin.routes(self)
  resources :termlists
  resources :loan_outs
  get 'users/switch_locale', to: 'users#switch_locale'
#resources :users

# Reports from reports_kit
  mount ReportsKit::Engine, at: '/'

  root 'static_pages#menu'
  get 'static_pages/reports'
  get 'jstreetest', to: 'static_pages#jstreetest'
  get 'jstreedata', to: 'static_pages#jstreedata'
  get 'builds/new'
  get 'static_pages/menu'

  get 'museum_objects/search' # remember that orders matter
  get 'museum_objects/search_result_invnumber'
  get 'museum_objects/search_form'
  get 'museum_objects/add_search_field'
  post 'museum_objects/export_pdf'
  get 'museum_objects/download_pdf'
  get 'museum_objects/check_for_new_pdf'
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
	get  '/import_translations/select', to: 'static_pages#import_translations_select'
  get  '/import_static_translations/select', to: 'static_pages#import_static_translations_select'
	post '/import_termlists/submit', to: 'static_pages#import_termlists_submit'
	post '/import_translations/submit', to: 'static_pages#import_translations_submit'
  post '/import_static_translations/submit', to: 'static_pages#import_static_translations_submit'


  # CRUDs
  resources :acquisition_delivered_bies

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
