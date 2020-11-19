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
end