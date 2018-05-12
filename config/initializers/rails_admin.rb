RailsAdmin.config do |config|
  
  # We hide join tables from has_many through, as
  # using inverse_of in model or in config.model did
  # not work as expected.
  hiding_models = 
    [
      "JoinMuseumObjectColor", 
      "JoinMuseumObjectDatingCentury",
      "JoinMuseumObjectMaterialSpecified",
      "TermlistKindOfObjectSpecifiedsColor",
      "TermlistKindOfObjectSpecifiedsDatingCenturie",
      "TermlistKindOfObjectSpecifiedsDatingMillennium",
      "TermlistKindOfObjectSpecifiedsDatingPeriod",
      "TermlistKindOfObjectSpecifiedsDecoration",
      "TermlistKindOfObjectSpecifiedsDecorationColor"
    ]

  config.excluded_models |= hiding_models
  
    # This did not hide the join tables as intended
    # note that include_all_fields must be added if used
    # config.model TermlistColor do
    #   include_all_fields
    #   field :museum_objects do
    #     inverse_of :termlist_colors
    #   end
    # end
  
    
  # not working unfortunately
  config.model TermlistColor do
    create do
      include_all_fields
      field :museum_objects do
        form_value = MuseumObject.first
      end
    end
  end


  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
end
