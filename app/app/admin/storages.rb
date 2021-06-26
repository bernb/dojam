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
    column :storage_locations
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
      row :storage_locations
      row :museum_objects do |storage|
        storage.museum_objects.count
      end
    end
  end


  
end
