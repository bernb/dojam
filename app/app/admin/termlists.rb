ActiveAdmin.register Termlist do
  actions :all, except: [:new]
  active_admin_import(
    on_duplicate_key_update: ["name_ar"],
    template_object: ActiveAdminImport::Model.new(
      hint: "file will be imported with such header format: 'name_en, 'name_ar' and updated based on column 'name_en'",
      csv_headers: ["id", "name_ar"]),
    before_batch_import: ->(importer) {
        names = importer.values_at("id").collect(&:strip)
        terms = Termlist.where(name_en: names).pluck(:name_en, :id)
        terms_hash = Hash[*terms.flatten]
        importer.csv_lines = importer.csv_lines
          .select{|l| l.first.in? terms_hash.keys}
          .map{|l| [terms_hash[l.first], l.second]}
      },
      after_batch_import: ->(importer) {
      }
  )
  permit_params :name_en, :name_ar
  filter :type, as: :select
  filter :name_en
  filter :name_ar
  filter :created_at
  filter :updated_at

  index do
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
    # We do not .underscore.humanize the type names as this would be error prone and to be done at a lot of places
    column :type
    column :position
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :type
      row :name_en
      row :name_ar
      row :museum_objects do |m|
        next if m.museum_objects.nil?
        @m_objects = Kaminari.paginate_array(m.museum_objects).page(params[:page]).per(50)
        result = @m_objects.map{|m| link_to m.decorate.full_inv_number, admin_museum_object_path(m)}
      end
      row :page do |p|
        next if @m_objects.nil?
        [page_entries_info(@m_objects), paginate(@m_objects)] unless @m_objects.nil?
      end
      row :position
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form do |f|
    f.semantic_errors
    inputs do
      li do
        label "Type"
        div f.object.type
      end
      input :name_en
      input :name_ar
      input :position
    end
    f.actions
  end
end
