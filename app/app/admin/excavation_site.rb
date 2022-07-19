ActiveAdmin.register ExcavationSite do
  permit_params :name
  filter :name
  filter :created_at
  filter :updated_at

  index do
    column :name do |excavation_site|
      link_to excavation_site.name, admin_excavation_site_path(excavation_site)
    end
    column :created_at
    column :updated_at
    column :museum_objects do |excavation_site|
      excavation_site.museum_objects&.count || 0
    end
    actions
  end

  show title: :name do
    attributes_table do
      row :name
      row :museum_objects do |m|
        @m_objects = Kaminari.paginate_array(m.museum_objects).page(params[:page]).per(200)
        @m_objects.map{|m| link_to m.decorate.full_inv_number, admin_museum_object_path(m)}
      end
      row :page do |p|
        [page_entries_info(@m_objects), paginate(@m_objects)]
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  form title: :name do |f|
    f.semantic_errors
    input :name
  f.actions
  end
end