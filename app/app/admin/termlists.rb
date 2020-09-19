ActiveAdmin.register Termlist do
  active_admin_import(
    on_duplicate_key_update: ["name_ar"],
    template_object: ActiveAdminImport::Model.new(
      hint: "file will be imported with such header format: 'name_en, 'name_ar' and updated based on column 'name_en'",
      csv_headers: ["id", "name_ar"]),
    before_batch_import: ->(importer) {
        names = importer.values_at("id").collect(&:strip)
        terms = Termlist.where(name_en: names).pluck(:name_en, :id)
        options = Hash[*terms.flatten]
        asdfasdf
        importer.batch_replace("id", options)
      }
  )
  permit_params :type, :name_en, :name_ar
  filter :name_en
  filter :name_ar
  filter :created_at
  filter :updated_at

  index do
    column :id
    column :type
    column :name_en do |m|
      link_to m.name_en, admin_termlist_path(m)
    end
    column :name_ar do |m|
      name_ar = m.name_ar
      if name_ar.blank?
        link_to "", admin_termlist_path(m)
      else
        link_to m.name_ar, admin_termlist_path(m)
      end
    end
    column :created_at
    column :updated_at
  end

  show do
    attributes_table do
      row :id
      row :name_en
      row :name_ar
      row :museum_objects do |m|
        @m_objects = Kaminari.paginate_array(m.museum_objects).page(params[:page]).per(50)
        result = @m_objects.map{|m| link_to m.decorate.full_inv_number, admin_museum_object_path(m)}
      end
      row :page do |p|
        [page_entries_info(@m_objects), paginate(@m_objects)]
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
