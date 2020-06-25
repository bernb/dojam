ActiveAdmin.register MuseumObject do
  filter :inv_number
  index do
    column :full_inv_number do |mo|
      link_to mo.decorate.full_inv_number, admin_museum_object_path(mo)
    end
  end
end
