ActiveAdmin.register MaterialSpecified do
  permit_params :type, :name 
  filter :name
  filter :material,
    as: :select,
    collection: Material.all
  filter :created_at
  filter :updated_at

  index do
    column :id
    column :name do |ms|
      link_to ms.name, admin_material_specified_path(ms)
    end
    column :material
    column :created_at
    column :updated_at
  end
end
