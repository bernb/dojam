ActiveAdmin.register MuseumObject do
  filter :inv_number
  index do
    column :full_inv_number do |mo|
      link_to mo.decorate.full_inv_number, admin_museum_object_path(mo)
    end
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
