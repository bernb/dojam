ActiveAdmin.register MuseumObject do
  index do
    exclude = ["images"]
    column :inv_number
  end
end
