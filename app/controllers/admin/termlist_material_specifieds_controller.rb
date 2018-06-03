module Admin
  class TermlistMaterialSpecifiedsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = TermlistMaterialSpecified.
    #     page(params[:page]).
    #     per(10)
    # end
		def update
			resource = TermlistMaterialSpecified.find params[:id]
			resource.update(material_specifieds_params)
			redirect_to admin_termlist_material_specifieds_path
		end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   TermlistMaterialSpecified.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
		private
		def material_specifieds_params
			params.require(:termlist_material_specified).permit(:id, :name)
		end
  end
end
