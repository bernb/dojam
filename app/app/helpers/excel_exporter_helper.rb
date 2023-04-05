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
                      I18n.t('description'),
                      I18n.t('excavation_site'),
                      I18n.t('excavation_site_kind'),
                      I18n.t('excavation_site_category'),
                      I18n.t('finding_context'),
                      I18n.t('finding_remarks'),
                      I18n.t('production_technique'),
                      I18n.t('munsell_color'),
                      I18n.t('decoration_style'),
                      I18n.t('decoration_technique'),
                      I18n.t('inscription_text'),
                      I18n.t('inscription_translation'),
                      I18n.t('inscription_language'),
                      I18n.t('inscription_decoration'),
                      I18n.t('inscription_letter'),
                      I18n.t('authenticity'),
                      I18n.t('dating_century'),
                      I18n.t('dating_millennium'),
                      I18n.t('dating_timespan'),
                      I18n.t('literature')
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
               m.dating_period_decorated,
               # More than 30k chars / 32kB will result in a corrupted file,
               # see https://github.com/zdavatz/spreadsheet/blob/master/GUIDE.md#cautionary-note-about-cell-content-length
               m.remarks&.[](0..30_000),
               m.excavation_site.name,
               m.excavation_site_kind.name,
               m.excavation_site_category.name,
               m.finding_context,
               m.finding_remarks,
               m.production_technique.name_en,
               m.munsell_color,
               m.decoration_style.name_en,
               m.decoration_technique.name_en,
               m.inscription_text,
               m.inscription_translation,
               m.inscription_language.name_en,
               m.inscription_decoration&.name_en || "",
               m.inscription_letter.name_en,
               m.authenticity.name_en,
               m.dating_century,
               m.dating_millennium,
               m.dating_timespan,
               m.literature

    end
    self.fit_columns(sheet)
    return export
  end
end