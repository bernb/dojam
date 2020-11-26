module TranslationHelper
  def self.clean_str(str)
    return self.clean_collection([str]).first
  end

  def self.clean_collection(array)
    return array
               .map(&:downcase)
               .map{|e| e.gsub(/[\/\-\\]/, "_")} # replace some chars used as seperators with underscore
               .map{|e| e.gsub(/[^0-9a-z_\s]/, "")} # remove everything except a-z and whitespace and underscore
               .map(&:squish) # remove trailing / leading underscores
               .map{|e| e.gsub(/\s/, '_')} # replace all remaining underscores with a whitespace
  end

  def self.transform_keys(path, simulate: true)
    search_pattern = /(?<=[^a-z]t\(['"]).*?(?=['"]\))/
    Dir.chdir(path)
    files = Dir.glob(%w[**/*.rb **/*.erb])
    files.each do |f|
      File.open(f).each_with_index do |l, i|
        result = l.scan(search_pattern)
        result.each do |r|
          puts "File #{File.basename(f)} in line #{i.to_s}, old/new:"
          puts l
          puts l.sub(r, self.clean_str(r))
        end
      end
    end
  end
end