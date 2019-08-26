module PgSearchHelper
  def reindex_all
    Rails.application.eager_load!
    ApplicationRecord.descendants.each do |model|
      begin
        PgSearch::Multisearch.rebuild(model, false)
        # Building the STI parent model removes all children indices
      rescue PgSearch::Multisearch::ModelNotMultisearchable
        next
      end
    end
  end
end
