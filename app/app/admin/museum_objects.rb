ActiveAdmin.register MuseumObject do
  filter :inv_number
  filter :storage_location
  filter :excavation_site, multiple: true


  index do
    column :full_inv_number do |mo|
      link_to mo.decorate.full_inv_number, admin_museum_object_path(mo)
    end
    column :storage
    column :storage_location
    column :main_material
    column :main_material_specified
    column :kind_of_object
    column :kind_of_object_specified
    actions
  end

  show do
    attributes_table do
      # ToDo: Clean up and rename remarks to description and remove unused description column
      MuseumObject.column_names.each do |c|
        if c == "remarks"
          row :description do |m|
            m.remarks
          end
        elsif c == "description"

        else
          row c.to_sym
        end
      end
    end
  end
end
