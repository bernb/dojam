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
    column :museum_object_count do |m|
      m.museum_objects.count
    end
  end

  show do
    attributes_table do
      row :id
      row :name
      row :material_specifieds
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

  form do |f|
    inputs 'material details' do
      @mo = Material.find params[:id]
      f.semantic_errors
      input :name 
      input :paths, as: :check_boxes, label: "material specifieds", collection: @mo.paths.reject{|p| p.depth != 2}.map{|p| [p.last_object_name, p.id]}
    end
    f.actions
  end
end
