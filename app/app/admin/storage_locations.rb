ActiveAdmin.register StorageLocation do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name_en, :storage_id, :name_ar
  remove_filter :museum_objects

  index do
    column :name_en do |storage|
      link_to storage.name_en, admin_storage_location_path(storage)
    end
    column :name_ar do |storage|
      link_to storage.name_ar, admin_storage_location_path(storage) unless storage.name_ar.nil?
    end
    column :storage
    column :museum_objects do |storage|
      storage.museum_objects.count
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
      row :storage
      row :museum_objects do |storage|
        storage.museum_objects.count
      end
    end
  end
  
end
