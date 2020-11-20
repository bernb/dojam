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
end