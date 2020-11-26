module TranslationHelper
  def self.clean_str(str)
    return self.clean_collection([str]).first
  end

  def self.clean_collection(array)
    return array
               .map(&:downcase)
               .map{|e| e.gsub(/[^a-z\s]/, "")}
               .map(&:squish)
               .map{|e| e.gsub(/\s/, '_')}
  end

  def self.transform_keys(path, simulate: true)
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