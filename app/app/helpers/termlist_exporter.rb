class TermlistExporter

	def self.call path: "./", filename: "termlist_export.txt"
		# Make sure all models are loaded
		Rails.application.eager_load!
		Termlist.descendants.each do |termlist_class|
			File.open(path + filename, "a+") do |file|
				termlist_name = termlist_class.to_s.underscore.pluralize
				file.write(termlist_name + ":\n")
				file.write(termlist_class.all.map(&:name).ai(plain: true, index: false))
				file.write("\n\n")
			end
		end
	end
end
