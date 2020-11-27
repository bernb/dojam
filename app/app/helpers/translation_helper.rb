module TranslationHelper
  @@search_pattern = /(?<=[^a-z]t\(['"]).*?(?=['"]\))/
  @@file_pattern = %w[**/*.rb **/*.erb]

  def self.missing_keys
    missing_keys = []
    files = Dir.glob(@@file_pattern)
    files.each do |f|
      text = File.read(f)
      matches = text.scan(@@search_pattern)
      matches.each do |match|
        I18n.t(match, raise: true, locale: "en")
      rescue I18n::MissingInterpolationArgument
        # noop
      rescue I18n::MissingTranslationData
        missing_keys << match
      end
    end
    missing_keys = missing_keys
        .sort
        .uniq.each{|k| puts k}
  end

  # Allow to clean a single string by wrapping it in an array
  def self.clean_str(str)
    return self.clean_collection([str]).first
  end

  # See comment for self.transform_keys
  def self.clean_collection(array)
    return array
               .map(&:downcase)
               .map{|e| e.gsub(/[\/\-\\]/, "_")} # replace some chars used as seperators with underscore
               .map{|e| e.gsub(/[^0-9a-z_\s]/, "")} # remove everything except a-z and whitespace and underscore
               .map(&:squish) # remove trailing / leading underscores
               .map{|e| e.gsub(/\s/, '_')} # replace all remaining underscores with a whitespace
  end

  # Search recursive in ruby files (.rb, .erb) for calls to translations t('string') and replace them with proper keys.
  # This was used as initial we used 'natural language' keys, i.e. t('no. of document'), but this lead to bugs as
  # characters as a dot has a special meaning. So this function would transform the example into t('no_of_document').
  # Note that this might lead to overlapping keys.
  def self.transform_keys(path, simulate: true)
    Dir.chdir(path)
    files = Dir.glob(@@file_pattern)
    files.each do |f|
      text = File.read(f)
      matches = text.scan(@@search_pattern)
      if matches.present?
        puts "File #{File.basename(f)} after replacement:"
        replace_hash = matches.zip(self.clean_collection(matches)).to_h
        puts text.gsub(@@search_pattern, replace_hash)
        puts "\n**********************************\n\n"
        if !simulate
          text.gsub!(@@search_pattern, replace_hash)
          File.open(f, 'w') {|file| file.puts text}
        end
      end
      # matches.each do |match|
      #   puts "File #{File.basename(f)} old/new:"
      #   puts text
      #   puts "--------"
      #   puts text.gsub(match, self.clean_str(r))
      # end
    end
    if simulate
      puts "No changes written! To actually rewrite the files set 'simulate: false'."
    end
  end
end