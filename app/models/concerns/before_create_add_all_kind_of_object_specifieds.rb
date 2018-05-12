module BeforeCreateAddAllKindOfObjectSpecifieds
  extend ActiveSupport::Concern
  
  included  do
    before_create :add_all_kind_of_object_specifieds
  end

  def add_all_kind_of_object_specifieds
    self.termlist_kind_of_object_specifieds |= TermlistKindOfObjectSpecified.all.to_a
  end

end
