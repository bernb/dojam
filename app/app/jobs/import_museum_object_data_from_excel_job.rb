class ImportMuseumObjectDataFromExcelJob < ApplicationJob
  queue_as :default
  after_perform do |job|
    current_user = job.arguments.second
    current_user.museum_object_import_running = false
    current_user.museum_objects_excel_import_file.purge_later
    current_user.save
  end

  def perform(log_path, user)
    user.museum_object_import_running = true
    user.save
    file_path = ActiveStorage::Blob.service.path_for(user.museum_objects_excel_import_file.key)
    file_extension = user.museum_objects_excel_import_file.filename.extension.to_sym
    MuseumObjectExcelImportService.import_from_file file_path, file_extension, log_path
  end
end
