ActiveAdmin.register Storage do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name_en, :name_ar

  index do
    column :name_en do |storage|
      link_to storage.name_en, admin_storage_path(storage)
    end
    column :name_ar do |storage|
      link_to storage.name_ar, admin_storage_path(storage) unless storage.name_ar.nil?
    end
    # ToDo: Create helper to unify how potentially large list are shown within the backend:
    # 1. Show first X entries, linkin to the admin show view
    # 2. Add link 'show all' linking to the admin index view with preset filter
    column :storage_locations
    column :museum_objects do |storage|
      mo_count = storage.museum_objects.count
      if mo_count == 0
        mo_count
      else
        link_to storage.museum_objects.count,
                admin_museum_objects_path(q:{storage_location_id_in: storage.storage_location_ids})
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name_en
      row :name_ar
      row :storage_locations
      row :museum_objects do |storage|
        storage.museum_objects.count
      end
    end
  end


  
end
