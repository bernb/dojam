RailsAdmin.config do |config|
  
  # We hide join tables from has_many through, as
  # using inverse_of in model or in config.model did
  # not work as expected.
  hiding_models = 
    [
      "JoinMuseumObjectColor", 
      "JoinMuseumObjectDatingCentury",
      "JoinMuseumObjectMaterialSpecified",
      "ColorsMsKooSpec",
      "DatingCenturiesMsKooSpec",
      "DatingMillenniaMsKooSpec",
      "DatingPeriodsMsKooSpec",
      "DecorationsMsKooSpec",
      "DecorationColorsMsKooSpec",
      "DecorationTechniquesMsKooSpec",
      "InscriptionLanguagesMsKooSpec",
      "InscriptionLettersMsKooSpec",
      "PreservationMaterialsMsKooSpec",
      "PreservationObjectsMsKooSpec",
      "ProductionTechniquesMsKooSpec",
      "ActiveStorage::Attachment",
      "ActiveStorage::Blob",
      "MuseumObjectImageList"
    ]
  # eager load throws error :(
  # note this must be before model excluding  
  #Rails.application.eager_load!
  #ActiveRecord::Base.descendants.each do |imodel|
  #  config.model "#{imodel.name}" do
  #    label label.split(' ',2)[1]
  #  end
  #end

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
    label label.split(' ',2)[1]
    #create do
    #  include_all_fields
    #  field :museum_objects do
    #    form_value = MuseumObject.first
    #  end
    #end
  end
  
  config.model Museum do
    navigation_label "Museum"
  end
  
  config.model MuseumObject do
    navigation_label "Museum"
    label "museum object"
  end
  
  config.model Storage do
    parent Museum
    navigation_label "Museum"
  end
  
  config.model StorageLocation do
    parent StorageLocation
    navigation_label "Museum"
  end
  
  config.model TermlistAcquisitionDeliveredBy do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistAcquisitionKind do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistAuthenticity do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistConservation do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistDatingCentury do
    navigation_label "Dating"
    label label.split(' ',2)[1]
  end
  
  config.model TermlistDatingMillennium do
    navigation_label "Dating"
    label label.split(' ',2)[1]
  end
  
  config.model TermlistDatingPeriod do
    navigation_label "Dating"
    label label.split(' ',2)[1]
  end
  
  config.model TermlistDecoration do
    navigation_label "Decoration"
    label label.split(' ',2)[1]
  end
  
  config.model TermlistDecorationTechnique do
    navigation_label "Decoration"
    label label.split(' ',2)[1]
  end
  
  config.model TermlistDecorationColor do
    navigation_label "Decoration"
    label "color"
  end
  
  config.model TermlistExcavationSiteCategory do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistExcavationSiteKind do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistInscriptionLanguage do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistInscriptionLetter do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistKindOfObject do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistKindOfObjectSpecified do
    parent TermlistKindOfObject
    label label.split(' ',2)[1]
  end
  
  config.model TermlistMaterialSpecified do
    label label.split(' ',2)[1]
    parent TermlistMaterial
  end
  
  config.model TermlistMaterial do
    label label.split(' ',2)[1]
  end
  
  config.model TermlistPreservationMaterial do
    navigation_label "Preservation"
    label label.split(' ',2)[1]
  end
  
  config.model TermlistPreservationObject do
    navigation_label "Preservation"
    label label.split(' ',2)[1]
  end
  
  config.model TermlistProductionTechnique do
    label label.split(' ',2)[1]
  end
  
  
  # rails_admin will look for inv_number on models
  # i.e. museum_objects for naming
  config.label_methods << :inv_number


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
