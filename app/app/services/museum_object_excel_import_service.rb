class MuseumObjectExcelImportService
  extend ExcelImporterHelper
  def self.import_from_file file, file_extension, log_path
    import_excel_from_file file, file_extension: file_extension, log_path: log_path
  end
end
