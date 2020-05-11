ActiveAdmin.register Material do
  permit_params :type, :name
  filter :name
  filter :created_at
  filter :updated_at

  index do
    column :id
    column :name do |m|
      link_to m.name, admin_material_path(m)
    end
    column :material_specifieds
    column :created_at
    column :updated_at
  end
end
