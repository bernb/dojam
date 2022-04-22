ActiveAdmin.register User, as: "Users" do
  permit_params :email,
                :museum_id,
                :is_enabled,
                :has_extended_access


  index do
    selectable_column
    id_column
    column :email
    column :museum
    column :created_at
    column :is_enabled
    column :has_extended_access
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :museum
      row :created_at
      row :is_enabled
      row :has_extended_access
    end
    active_admin_comments
  end

  filter :email
  filter :museum
  filter :is_enabled
  filter :has_extended_access
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :museum
      f.input :is_enabled, as: :boolean
      f.input :has_extended_access
    end
    f.actions
  end

end
