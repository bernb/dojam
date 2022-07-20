ActiveAdmin.register Museum do
  permit_params :name

  index do
    column :name do |museum|
      link_to museum.name, admin_museum_path(museum)
    end
    column :storages do |museum|
      museum.storages.each do |storage|
        link_to storage.name, admin_storage_path(storage)
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :storages do |museum|
        museum.storages.each do |storage|
          link_to storage.name, admin_storage_path(storage)
        end
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors
    inputs do
      input :name
    end
    f.actions
  end
end