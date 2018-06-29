module Admin
  class TermlistColorsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = TermlistColor.
    #     page(params[:page]).
    #     per(10)
    # end

		def new
			@materials = TermlistMaterial.all
			super
		end

		def create
			@resource = TermlistColor.create(name: params[:termlist_color][:name])
			flash[:success] = "Created successfully."
			PropsSetter.call property_name: :termlist_colors, 
											 property: @resource, 
											 koos: params[:termlist_color][:termlist_kind_of_object_specified_ids], 
											 material_specified: params[:termlist_color][:termlist_material_specified_ids]
			redirect_to :admin_termlist_colors
		end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   TermlistColor.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
