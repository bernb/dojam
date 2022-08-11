class MuseumObjectExcelImportService
  extend ExcelImporterHelper
  def self.import_from_file file, log_path
    import_excel_from_file file, log_path: log_path
  end
end
