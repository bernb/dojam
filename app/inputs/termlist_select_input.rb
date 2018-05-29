class TermlistSelectInput < SimpleForm::Inputs::CollectionSelectInput
	def input(wrapper_options)
		merged_inputs = merge_wrapper_options(input_html_options, wrapper_options)
		label_method = :to_s
    value_method = :to_s

    @builder.collection_select(
      attribute_name, collection, value_method, label_method,
      input_options, merged_inputs
    )
  end

	def input_html_classes
		super.push('termlist_select_input')
	end
end
