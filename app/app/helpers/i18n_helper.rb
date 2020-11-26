module I18nHelper
  def translate(key, options={})
    if key == ""
      return ""
    end
    super(key, options.merge(raise: true))
  rescue I18n::MissingTranslationData
    key
  end
  alias :t :translate

  module KeyTranslator
    def self.call(path, simulate: true)
      search_pattern = /t\(['"](.*?)['"]\)/
      Dir.chdir(path)
      files = Dir.glob("**/")
      files.each do |f|
        File.eachline.with_index(f) do |l, i|
          result = l.scan(search_pattern)
          result.each do |r|
            puts "File #{File.basename(f)} in line #{i.to_s}, old/new:"
            puts l
            puts l.sub(r, transform_key(r))
          end
        end
      end
    end
  end
end