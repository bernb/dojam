module ExcelExporterHelper
  require 'spreadsheet'
  def self.fit_columns(sheet)
    (0...sheet.column_count).each do |col_idx|
      column = sheet.column(col_idx)
      column.width = column.each_with_index.map do |cell, row|
        chars = cell.present? ? cell.to_s.strip.split('').count + 4 : 1
        ratio = sheet.row(row).format(col_idx).font.size / 10
        (chars * ratio).round
      end.max
    end
    return sheet
  end

  # Not used in the application itself, but for research purposes where we want labeled images
  def self.create_image_property_sheet
    require 'csv'
    file = "export.csv"
    museum_objects = MuseumObject.all
    headers = [
      'id',
      I18n.t('material'),
      I18n.t('material_specified'),
      I18n.t('kind_of_object'),
      I18n.t('kind_of_object_specified'),
      I18n.t('preservation_of_object'),
      I18n.t('description'),
      'filename'
    ]
    CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
      museum_objects.each do |m|
        row = [
          m.id,
          m.main_material&.name,
          m.main_material_specified&.name,
          m.kind_of_object&.name,
          m.kind_of_object_specified&.name,
          m.preservation_object&.name,
          # More than 30k chars / 32kB will result in a corrupted file,
          # see https://github.com/zdavatz/spreadsheet/blob/master/GUIDE.md#cautionary-note-about-cell-content-length
          m.remarks&.[](0..30_000),
          m.images&.main&.blob&.key
        ]
        writer << row
      end
    end
  end

  def self.create_sheet(ids)
    export = Spreadsheet::Workbook.new
    sheet = export.create_worksheet
    museum_objects = MuseumObject.where(id: ids).map(&:decorate)
    sheet.row(0).push I18n.t('on_loan_to_institution'),
                      I18n.t('museum'),
                      I18n.t('inventory_no_incl_extension'),
                      I18n.t('other_inventory_no'),
                      I18n.t('location'),
                      I18n.t('detailed_location'),
                      I18n.t('site_name'),
                      I18n.t('material'),
                      I18n.t('material_specified'),
                      I18n.t('kind_of_object'),
                      I18n.t('kind_of_object_specified'),
                      I18n.t('preservation_of_object'),
                      I18n.t('dating_period'),
                      I18n.t('description')
    museum_objects.each_with_index do |m, i|
      row = sheet.row(i+1)
      row.push m.loan_out&.to_institution || "",
               m.museum.name,
               m.full_inv_number,
               m.inv_numberdoa,
               m.storage&.name,
               m.storage_location.name,
               m.excavation_site.name,
               m.main_material&.name,
               m.main_material_specified&.name,
               m.kind_of_object&.name,
               m.kind_of_object_specified&.name,
               m.preservation_object&.name,
               m.dating_period&.name,
               # More than 30k chars / 32kB will result in a corrupted file,
               # see https://github.com/zdavatz/spreadsheet/blob/master/GUIDE.md#cautionary-note-about-cell-content-length
               m.remarks&.[](0..30_000)
    end
    self.fit_columns(sheet)
    return export
  end
end