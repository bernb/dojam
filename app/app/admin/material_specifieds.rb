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
    column :museum_objec_count do |m|
      m.museum_objects.count
    end
  end

  show do
    attributes_table do
      row :id
      row :name
      row :kind_of_objects do |m|
        m.kind_of_objects.map{|koo| link_to koo.name, '#'}
      end
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
    inputs 'material specified details' do
      @ms = MaterialSpecified.find params[:id]
      @materials = Material.all.map{|m| [m.name, m.id]}
      @all_ms = MaterialSpecified.all
      semantic_errors
      input :name
      input :material, label: "current material", as: :string, 
        collection: @ms.material, 
        input_html: {disabled: true}
      input :material, label: "move to material", as: :select, 
        collection: @materials, 
        include_blank: true,
        hint: "this will associate #{@ms.name} with the selected material"
      input :new_material_specified, label: "merge into", as: :select, 
        collection: @all_ms, 
        hint: "this will delete #{@ms.name} and move all associated terms and museum object to the selected material specified"
      actions
    end
  end

end
