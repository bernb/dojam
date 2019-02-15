require "rails_helper"

RSpec.describe TermlistsImporterHelper, type: :helper do
	describe "#parse_import_file" do
    before(:each) do
      @fixture_path = "#{Rails.root}/spec/fixtures/files/yaml/"
    end
    it "should use psych's safe_load method to load yaml files" do
      file = fixture_file_upload @fixture_path + "malicious_file.yaml"
      expect{helper.parse_import_files [file]}.to raise_error(Psych::DisallowedClass)
    end
    it "should disallow files that are not .yaml files" do
      file = fixture_file_upload @fixture_path + "wrong_ext.doc"
      materials_for_import, warnings = helper.parse_import_files [file]
      expect(materials_for_import).to be_empty
    end
    it "should disallow files with invalid terms" do
      file = fixture_file_upload @fixture_path + "invalid_terms.yaml"
      materials_for_import, warnings = helper.parse_import_files [file]
      expect(materials_for_import).to be_empty
    end
    it "should allow to import a correctly formatted yaml file with only whitelisted entries" do
      file = fixture_file_upload @fixture_path + "valid_termlist_file.yaml"
      materials_for_import, warnings = helper.parse_import_files [file]
      expect(warnings).to be_empty
      expect(materials_for_import.count).to eq(1)
    end
	end
end
