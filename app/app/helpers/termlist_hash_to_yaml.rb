module TermlistHashToYaml
  def termlist_to_yaml path 
    data_string  = File.read(path)
    hash_name = data_string[/\$[a-z_]*/]
    eval(data_string)
    yaml_data = transform(hash_name)
    write_to_disk(path, yaml_data)
  end

  private
  def transform hash_name
    eval(hash_name)
      .to_yaml
      .gsub(/:(?=[a-z])/,'')
      .sub(/decoration_styles/, 'decorations')
  end

  def write_to_disk path, yaml_data
    dir = File.dirname path 
    basename = File.basename path, '.rb'
    fullpath = dir + '/' + basename + '.yaml'
    File.open(fullpath, 'w') {|file| file.write yaml_data}
  end
end
