require "rails_helper"

RSpec.describe TermlistsImporterHelper, type: :helper do
	describe "#parse_import_file" do
    it "should use psych's safe_load method to load yaml files" do
      file = fixture_file_upload "#{Rails.root}/spec/fixtures/files/yaml/malicious_file.yaml"
      expect{helper.parse_import_files [file]}.to raise_error(Psych::DisallowedClass)
    end
    it "should disallow files that are not .yaml files"
    it "should disallow files with invalid terms"
    it "should allow to import a correctly formatted yaml file with only whitelisted entries"
	end
end
