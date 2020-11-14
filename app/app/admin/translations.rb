ActiveAdmin.register Translation, as: "Translations" do
  after_update :reload_i18n_backend
  after_create :reload_i18n_backend
  permit_params :locale, :key, :value
  filter :locale
  filter :key
  filter :value

  index do
    column :id
    column :locale
    column :key do |k|
      link_to k.key.to_s, admin_translation_path(k)
    end
    column :value do |v|
      link_to v.value.to_s, admin_translation_path(v)
    end
    column :created_at
    column :updated_at
  end

  show title: :key do
    attributes_table do
      row :id
      row :locale
      row :key
      row :value
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  controller do
    def reload_i18n_backend(_)
      I18n.backend.reload!
    end
  end
end
